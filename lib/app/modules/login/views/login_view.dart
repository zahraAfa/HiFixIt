import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hifixit/app/modules/login/views/widgets/login_body.dart';
import 'package:hifixit/app/widgets/auth/log_reg_form_body.dart';

import '../controllers/login_controller.dart';
import 'package:hifixit/app/widgets/auth/header_login_regist.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  get title => 'HiFixIt';

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
          LoginBody(
            pageType: 'Sign in',
            message: 'Don\'t have an account yet ? ',
          ),
        ],
      ),
    );
  }
}
