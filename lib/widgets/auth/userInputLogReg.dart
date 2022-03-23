import 'package:flutter/material.dart';

class UserInputLogReg extends StatelessWidget {
  UserInputLogReg({
    Key? key,
    this.hintTitle,
    this.keyboardType,
    this.obscureText,
    required this.onChanged,
  }) : super(key: key);

  final String? hintTitle;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final userInput = TextEditingController();
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 25.0,
          right: 25.0,
        ),
        child: TextField(
          onChanged: onChanged,
          keyboardType: keyboardType,
          obscureText: obscureText ?? false,
          controller: userInput,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintTitle,
            hintStyle: const TextStyle(
              fontSize: 18,
              color: Colors.grey,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
    );
  }
}
