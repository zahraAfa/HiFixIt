import 'package:flutter/material.dart';
import 'package:hifixit/app/widgets/user_option_btn.dart';

class WelcomingPage extends StatelessWidget {
  const WelcomingPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Text(
                'Technician Repair Services Finder',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 130.0,
              ),
              const UserOptionBtn(
                color: Color(0xFF682C76),
                userIcon: Icons.account_circle_sharp,
                userType: 'Customer',
                nav: 'loginCust',
              ),
              const SizedBox(
                height: 30.0,
              ),
              const UserOptionBtn(
                color: Color(0xFF7B4067),
                userIcon: Icons.build_circle_rounded,
                userType: 'Technician',
                nav: 'loginTech',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
