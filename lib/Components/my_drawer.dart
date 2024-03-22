import 'package:chat_app/pages/settings_page.dart';
import 'package:chat_app/Services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

    void logout() {
    final auth = AuthService();
    auth.signout();
  }
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                  child: Center(
                      child: Icon(
                FontAwesomeIcons.solidMessage,
                size: 64,
                color: Theme.of(context).colorScheme.primary,
              ))),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  title: const Text("H o m e"),
                  leading: const Icon(FontAwesomeIcons.house),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  title: const Text("S e t t i n g s"),
                  leading: const Icon(FontAwesomeIcons.gear),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const SettingsPage()));
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, bottom: 25),
            child: ListTile(
              title: const Text("L o g o u t"),
              leading: const Icon(FontAwesomeIcons.arrowRightFromBracket),
              onTap: logout,
            ),
          )
        ],
      ),
    );
  }
}
