import 'package:chat_app/Components/my_button.dart';
import 'package:chat_app/Components/my_textform.dart';
import 'package:chat_app/Services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterPage extends StatelessWidget {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final void Function()? onTap;


  RegisterPage({super.key , required this.onTap});

  void register(BuildContext context) {
    final auth = AuthService();
    if(_passwordController.text == _confirmPassword.text){
    try{
    auth.signupWithEmailAndPassword(_emailController.text, _passwordController.text);
    } catch (e){
            showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(e.toString()),
                ));
    }
    }
    else
    {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title: Text("Passwords Don't match"),
              ));
    }
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
          backgroundColor:
              Theme.of(context).colorScheme.background, // Status bar color
          scrolledUnderElevation: 0),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.solidMessage,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 50),
            Text(
              "Let's create an account",
              style: TextStyle(
                  fontSize: 16, color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(height: 25),
            MyTextFrom(
              hintText: "Email",
              obsecureText: false,
              textController: _emailController,
            ),
            const SizedBox(height: 10),
            MyTextFrom(
              hintText: "Password",
              obsecureText: true,
              textController: _passwordController,
            ),
                        const SizedBox(height: 10),
            MyTextFrom(
              hintText: "Confirm Password",
              obsecureText: true,
              textController: _confirmPassword,
            ),
            const SizedBox(height: 25),
            MyButton(
              buttonText: "register",
              onTap: () => register(context),
            ),
            const SizedBox(height: 25),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "Already a member?  ",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  "Login now",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary),
                ),
              )
            ])
          ],
        ),
      ),
    );
  }
}