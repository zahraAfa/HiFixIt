import 'package:flutter/material.dart';
import 'package:hifixit/app/widgets/auth/log_reg_form_body.dart';
import 'package:hifixit/app/widgets/auth/header_login_regist.dart';

class RegistPage extends StatelessWidget {
  const RegistPage({Key? key, required this.title}) : super(key: key);

  final String title;

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
            title: title,
            thirdMessage: 'Join us!',
          ),
          const LoginRegistFormBody(
            pageType: 'Sign up',
            message: 'Already have an account ? ',
          ),
        ],
      ),
    );
  }
}
