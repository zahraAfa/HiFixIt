import 'package:flutter/material.dart';
import 'package:hifixit/widgets/menu_list_with_icon.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 2.0,
      backgroundColor: const Color(0xFF682C76),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  accountEmail: const Text('email@gmail.com'),
                  accountName: const Text('Name'),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF3D1B23),
                        Color(0xFF682C76),
                      ],
                    ),
                  ),
                  currentAccountPicture: CircleAvatar(
                    child: ClipOval(
                      child: Image.network(
                        'https://images.unsplash.com/photo-1523730205978-59fd1b2965e3?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8ZGVmYXVsdHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
                        fit: BoxFit.cover,
                        width: 90,
                        height: 90,
                      ),
                    ),
                  ),
                ),
                const MenuListWithIcon(icon: Icons.home_filled, title: 'Home'),
                const MenuListWithIcon(
                    icon: Icons.calendar_month, title: 'Calendar'),
                const MenuListWithIcon(
                    icon: Icons.chat_bubble_rounded, title: 'Chats'),
                const MenuListWithIcon(
                    icon: Icons.history, title: 'Book History'),
                const MenuListWithIcon(icon: Icons.settings, title: 'Settings'),
              ],
            ),
          ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Column(
              children: const [
                Divider(),
                MenuListWithIcon(icon: Icons.logout, title: 'Sign out'),
                SizedBox(
                  height: 40.0,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
