import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hifixit/app/modules/customer/modules/authentication/views/login_screen.dart';
import 'package:hifixit/app/modules/customer/modules/mainScreen/views/main_screen_cust.dart';
import 'package:hifixit/services/global.dart';
import 'package:hifixit/app/modules/technician/modules/authentication/views/login_screen.dart';
import 'package:hifixit/app/modules/technician/modules/mainScreens/main_screens_tech.dart';
import 'package:hifixit/widgets/user_option_btn.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  startTimer() {
    Timer(const Duration(seconds: 1), () async {
      if (await fAuth.currentUser != null) {
        currentFirebaseUser = fAuth.currentUser;
        Navigator.push(
            // context, MaterialPageRoute(builder: (c) => MainScreenTech()));
            context,
            MaterialPageRoute(builder: (c) => MainScreenCust()));
      } else {
        Navigator.push(
            context,
            // MaterialPageRoute(builder: (c) => const LoginScreenTech()));
            MaterialPageRoute(builder: (c) => const LoginScreenCust()));
      }
      // send user to home screen
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF3D1B23),
              Color(0xFFA049B4),
            ],
          ),
          image: DecorationImage(
              image: AssetImage('assets/images/welcome-hifixit.png'),
              alignment: Alignment.bottomCenter,
              fit: BoxFit.contain),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "HiFixIt",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Technician Repair Services Finder',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 130.0,
              ),
              UserOptionBtn(
                color: Color(0xFF682C76),
                userIcon: Icons.account_circle_sharp,
                userType: 'Customer',
                nav: 'login',
              ),
              SizedBox(
                height: 30.0,
              ),
              UserOptionBtn(
                color: Color(0xFF7B4067),
                userIcon: Icons.build_circle_rounded,
                userType: 'Technician',
                nav: 'regist',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
