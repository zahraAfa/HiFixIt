import 'package:flutter/material.dart';
import 'package:hifixit/widgets/auth/header_login_regist.dart';
import 'package:hifixit/widgets/auth/log_reg_form_body.dart';

class CustLogin extends StatelessWidget {
  static const routeName = '/authentification-screen';

  CustLogin({Key? key, required this.title}) : super(key: key);
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
            thirdMessage: 'please Sign in',
          ),
          const LoginRegistFormBody(
            pageType: 'Sign in',
            message: 'Don\'t have an account yet ? ',
          ),
        ],
      ),
    );
  }
}