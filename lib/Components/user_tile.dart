import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const UserTile({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [ const Icon(FontAwesomeIcons.solidCircleUser),
          const SizedBox(width: 10,),
          Text(text)],
        ),
      ),
    );
  }
}
