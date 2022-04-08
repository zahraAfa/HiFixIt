import 'package:flutter/material.dart';
import 'package:hifixit/technician/authentication/widgets/header_login_regist.dart';
import 'package:hifixit/technician/authentication/widgets/log_form_body.dart';

class LoginScreenTech extends StatefulWidget {
  const LoginScreenTech({Key? key}) : super(key: key);
  final title = "HiFixIt";

  @override
  State<LoginScreenTech> createState() => _LoginScreenTechState();
}

class _LoginScreenTechState extends State<LoginScreenTech> {
  @override
  Widget build(BuildContext context) {
    double _fullHeigh = MediaQuery.of(context).size.height;
    double _fullWidht = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: _fullWidht,
            height: _fullHeigh,
            color: const Color(0xFFF2F2F2),
          ),
          HeaderLoginRegist(
            title: widget.title,
            thirdMessage: 'Join us!',
          ),
          const LoginFormBody(
            pageType: 'Sign in',
            message: 'Already have an account ? ',
          ),
        ],
      ),
    );
  }
}
