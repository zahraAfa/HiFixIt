import 'package:flutter/material.dart';

class UserOptionBtn extends StatefulWidget {
  const UserOptionBtn(
      {Key? key,
      required this.userType,
      required this.userIcon,
      required this.color})
      : super(key: key);

  final String userType;
  final IconData userIcon;
  final Color color;

  @override
  State<UserOptionBtn> createState() => _UserOptionBtnState();
}

class _UserOptionBtnState extends State<UserOptionBtn> {
  Color _onTapColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() {
        _onTapColor =
            _onTapColor == Colors.white ? Colors.grey.shade300 : Colors.white;
        print('button tapped');
      }),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        height: 130,
        width: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          // color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: _onTapColor,
              spreadRadius: 3,
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(
              widget.userIcon,
              color: widget.color,
              size: 70,
            ),
            const SizedBox(
              height: 7.0,
            ),
            Text(
              widget.userType,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
