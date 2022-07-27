import 'package:flutter/material.dart';
import 'package:hifixit/app/modules/technician/modules/authentication/widgets/category_form_body.dart';
import 'package:hifixit/app/modules/technician/modules/authentication/widgets/header_login_regist.dart';

class CategoryInfoRegistScreen extends StatefulWidget {
  const CategoryInfoRegistScreen({Key? key}) : super(key: key);
  final title = "HiFixIt";

  @override
  State<CategoryInfoRegistScreen> createState() =>
      _CategoryInfoRegistScreenState();
}

class _CategoryInfoRegistScreenState extends State<CategoryInfoRegistScreen> {
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
          const CategoryFormBody(),
        ],
      ),
    );
  }
}
