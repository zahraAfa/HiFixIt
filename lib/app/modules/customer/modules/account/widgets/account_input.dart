import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AccountInputCust extends StatefulWidget {
  const AccountInputCust({
    Key? key,
    this.hintTitle,
    this.keyboardType,
    this.obscureText,
    this.enabled,
    required this.onChanged,
  }) : super(key: key);

  final String? hintTitle;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final bool? enabled;
  final ValueChanged<String> onChanged;

  // validateForm(){}

  @override
  State<AccountInputCust> createState() => _AccountInputCustState();
}

class _AccountInputCustState extends State<AccountInputCust> {
  final TextEditingController userInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0, top: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
        ),
        child: TextField(
          enabled: widget.enabled ?? true,
          onChanged: widget.onChanged,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText ?? false,
          controller: userInput,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hintTitle,
            hintStyle: const TextStyle(
              fontSize: 15,
              color: Colors.black,
              // fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
    );
  }
}
