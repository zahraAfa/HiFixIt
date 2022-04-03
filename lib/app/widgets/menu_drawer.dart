import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hifixit/app/controllers/auth_controller.dart';
import 'package:hifixit/app/widgets/menu_list_with_icon.dart';

class MenuDrawer extends StatelessWidget {
  final authCont = Get.find<AuthController>();
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
                MenuListWithIcon(
                    icon: Icons.home_filled,
                    title: 'Home',
                    onTap: () {
                      print('Home');
                    }),
                MenuListWithIcon(
                  icon: Icons.calendar_month,
                  title: 'Calendar',
                  onTap: () {},
                ),
                MenuListWithIcon(
                  icon: Icons.chat_bubble_rounded,
                  title: 'Chats',
                  onTap: () {},
                ),
                MenuListWithIcon(
                  icon: Icons.history,
                  title: 'Book History',
                  onTap: () {},
                ),
                MenuListWithIcon(
                  icon: Icons.settings,
                  title: 'Settings',
                  onTap: () {},
                ),
              ],
            ),
          ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Column(
              children: [
                const Divider(),
                MenuListWithIcon(
                  icon: Icons.logout,
                  title: 'Sign out',
                  onTap: () {
                    authCont.logout();
                  },
                ),
                const SizedBox(
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
