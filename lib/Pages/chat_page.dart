import 'package:chat_app/Components/chat_bubble.dart';
import 'package:chat_app/Components/my_textform.dart';
import 'package:chat_app/Services/auth/auth_service.dart';
import 'package:chat_app/Services/chat/chat_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatPage extends StatefulWidget {
  final String recieverEmail;
  final String recieiverID;

  const ChatPage(
      {super.key, required this.recieverEmail, required this.recieiverID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();

  final ChatServices _chatServices = ChatServices();

  final AuthService _authService = AuthService();

  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    myFocusNode.addListener(() {
      Future.delayed(
        const Duration(milliseconds: 500),
        () => scrollDown(),
      );
    });
    Future.delayed(const Duration (microseconds: 500),()=>scrollDown());
  }

  @override
  void dispose() {
    super.dispose();
    myFocusNode.dispose();
    _messageController.dispose();
  }

  final ScrollController _scrollController = ScrollController();
  void scrollDown() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      _chatServices.sendMessage(widget.recieiverID, _messageController.text);
    }
    _messageController.clear();
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(widget.recieverEmail),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.grey,
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildUserInput()
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatServices.getMessages(senderID, widget.recieiverID),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading . . .");
          }

          return ListView(
              controller: _scrollController,
              children: snapshot.data!.docs
                  .map((doc) => _buildMessageItem(doc))
                  .toList());
        });
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
      alignment: alignment,
      child: ChatBubble(isCurrentUser: isCurrentUser, message: data["message"]),
    );
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Row(
        children: [
          Expanded(
              child: MyTextFrom(
                  focusNode: myFocusNode,
                  hintText: "Type a Message",
                  obsecureText: false,
                  textController: _messageController)),
          Container(
            decoration: const BoxDecoration(
                color: Colors.green, shape: BoxShape.circle),
            margin: const EdgeInsets.only(right: 25),
            child: IconButton(
                onPressed: sendMessage,
                icon: const Icon(
                  FontAwesomeIcons.solidPaperPlane,
                  color: Colors.white,
                )),
          )
        ],
      ),
    );
  }
}
