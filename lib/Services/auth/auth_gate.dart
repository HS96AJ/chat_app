import 'package:chat_app/pages/home_page.dart';
import 'package:chat_app/Services/auth/login_or_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            // ignore: prefer_const_constructors
            return HomePage();
          }
          else{
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}