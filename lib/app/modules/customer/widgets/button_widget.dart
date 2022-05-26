import 'package:flutter/material.dart';

class ButtonHeaderWidget extends StatelessWidget {
  const ButtonHeaderWidget({
    Key? key,
    required this.title,
    required this.text,
    required this.onClicked,
  }) : super(key: key);
  final String title;
  final String text;
  final VoidCallback onClicked;

  @override
  Widget build(BuildContext context) => Container(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Align(alignment: Alignment.centerLeft, child: Text(title)),
            SizedBox(
              height: 10,
            ),
            ButtonDateWidget(
              onClicked: onClicked,
              text: text,
            ),
          ],
        ),
      );
}

class ButtonDateWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  const ButtonDateWidget(
      {Key? key, required this.onClicked, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            minimumSize: Size.fromHeight(40),
            primary: Colors.white),
        onPressed: onClicked,
        child: FittedBox(
          child: Text(
            text,
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
}
