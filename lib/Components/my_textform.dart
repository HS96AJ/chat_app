import 'package:flutter/material.dart';

class MyTextFrom extends StatelessWidget {

  final String hintText;
  final bool obsecureText;
  final TextEditingController textController;
  final FocusNode? focusNode;

  const MyTextFrom({super.key,required this.hintText, required this.obsecureText,required this.textController, this.focusNode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:25),
      child: TextFormField(
        controller: textController,
        focusNode: focusNode,
        obscureText: obsecureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.tertiary)),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary)),
        ),
      ),
    );
  }
}
