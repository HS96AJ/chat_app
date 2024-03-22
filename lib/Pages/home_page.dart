import 'package:chat_app/Components/my_drawer.dart';
import 'package:chat_app/Components/user_tile.dart';
import 'package:chat_app/Pages/chat_page.dart';
import 'package:chat_app/Services/auth/auth_service.dart';
import 'package:chat_app/Services/chat/chat_services.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ChatServices _chatServices = ChatServices();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,

      appBar: AppBar(
        title: const Text("Home Page"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.grey,
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatServices.getUserStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading . . .");
          }

          return ListView(
              children: snapshot.data!
                  .map<Widget>(
                      (userData) => _buildUserListItem(userData, context))
                  .toList());
        });
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return UserTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPage(
                        recieverEmail: userData["email"],
                        recieiverID: userData["uid"],
                      )));
        },
        text: userData["email"],
      );
    } else {
      return Container();
    }
  }
}
