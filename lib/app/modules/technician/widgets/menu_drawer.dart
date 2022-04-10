import 'package:flutter/material.dart';
import 'package:hifixit/app/controllers/global.dart';
import 'package:hifixit/app/modules/splashScreen/splash_screen.dart';
import 'package:hifixit/app/modules/technician/widgets/menu_list_with_icon.dart';

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
                    fAuth.signOut();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => const MySplashScreen()));
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
