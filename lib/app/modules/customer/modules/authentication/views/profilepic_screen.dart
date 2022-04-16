import 'package:flutter/material.dart';
import 'package:hifixit/app/modules/customer/modules/authentication/widgets/header_login_regist.dart';
import 'package:hifixit/app/modules/customer/modules/authentication/widgets/profilepic_form_body.dart';

class ProfilePicScreen extends StatefulWidget {
  const ProfilePicScreen({Key? key}) : super(key: key);
  final title = "HiFixIt";

  @override
  State<ProfilePicScreen> createState() => _ProfilePicScreenState();
}

class _ProfilePicScreenState extends State<ProfilePicScreen> {
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
          const ProfPicFormBody(),
        ],
      ),
    );
  }
}
