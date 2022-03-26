import 'package:flutter/material.dart';

class MenuListWithIcon extends StatelessWidget {
  const MenuListWithIcon({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      onTap: () {},
    );
  }
}
