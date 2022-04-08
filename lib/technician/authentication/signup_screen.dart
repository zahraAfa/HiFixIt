import 'package:flutter/material.dart';
import 'package:hifixit/technician/authentication/widgets/header_login_regist.dart';
import 'package:hifixit/technician/authentication/widgets/signup_form_body.dart';

class SignUpScreenTech extends StatefulWidget {
  const SignUpScreenTech({Key? key}) : super(key: key);
  final title = "HiFixIt";

  @override
  State<SignUpScreenTech> createState() => _SignUpScreenTechState();
}

class _SignUpScreenTechState extends State<SignUpScreenTech> {
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
          const SignupFormBody(
            pageType: 'Sign up',
            message: 'Already have an account ? ',
          ),
        ],
      ),
    );
  }
}
