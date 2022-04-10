import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserInputLogReg extends StatefulWidget {
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
  final ValueChanged<String> onChanged;

  // validateForm(){}

  @override
  State<UserInputLogReg> createState() => _UserInputLogRegState();
}

class _UserInputLogRegState extends State<UserInputLogReg> {
  final TextEditingController userInput = TextEditingController();

  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    // String? hintTitle = widget.hintTitle;

    // validateForm() {
    //   if (hintTitle != null) {
    //     switch (hintTitle) {
    //       case "Email":
    //         {
    //           if (!userInput.text.contains("@")) {
    //             Fluttertoast.showToast(msg: "Email address is not valid.");
    //           }
    //         }
    //         break;
    //       case "Password":
    //         {
    //           if (userInput.text.length < 6) {
    //             Fluttertoast.showToast(
    //                 msg: "Password must be at least 6 characters.");
    //           }
    //         }
    //         break;
    //     }
    //   } else {
    //     Fluttertoast.showToast(msg: "Cannot be blank.");
    //   }
    // }

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
          onChanged: widget.onChanged,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText ?? false,
          controller: userInput,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hintTitle,
            errorText: _validate ? 'Value Can\'t Be Empty' : null,
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
