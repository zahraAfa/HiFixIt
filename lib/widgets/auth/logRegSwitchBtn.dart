import 'package:flutter/material.dart';

class LogRegSwitchBtn extends StatelessWidget {
  const LogRegSwitchBtn({
    required this.btnTitle,
    required this.message,
    Key? key,
  }) : super(key: key);

  final String message;
  final String btnTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          message,
          style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            btnTitle,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
