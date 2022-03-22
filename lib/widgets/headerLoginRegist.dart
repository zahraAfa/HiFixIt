import 'package:flutter/material.dart';

class HeaderLoginRegist extends StatelessWidget {
  const HeaderLoginRegist({
    Key? key,
    required this.title,
    required this.thirdMessage,
  }) : super(key: key);

  final String title;
  final String thirdMessage;

  @override
  Widget build(BuildContext context) {
    double _fullHeigh = MediaQuery.of(context).size.height;
    double _fullWidht = MediaQuery.of(context).size.width;

    return Container(
      width: _fullWidht,
      height: _fullHeigh * 0.5,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFEF8A56),
            Color(0xFF682C76),
            Color(0xFF682C76),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(35.0, 130.0, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 35.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              'to $title',
              style: const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 17.0,
                color: Colors.white,
              ),
            ),
            Text(
              thirdMessage,
              style: const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 17.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
