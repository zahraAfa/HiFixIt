import 'package:flutter/material.dart';
import 'package:hifixit/app/modules/customer/modules/account/views/cust_account.dart';
import 'package:hifixit/app/modules/customer/modules/chat/views/chats_page.dart';
import 'package:hifixit/app/modules/customer/modules/history/views/history_tab.dart';
import 'package:hifixit/app/modules/customer/modules/mainScreen/views/main_screen_cust.dart';
import 'package:hifixit/app/modules/customer/modules/schedule/views/schedule_tab.dart';
import 'package:hifixit/app/services/global.dart';
import 'package:hifixit/app/modules/splashScreen/views/splash_screen.dart';
import 'package:hifixit/app/modules/customer/widgets/menu_list_with_icon.dart';

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
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => const CustAccount()));
                  },
                  child: UserAccountsDrawerHeader(
                    accountEmail: sharedPreferences!.getString("email")!.isEmpty
                        ? Text("NoEmail")
                        : Text(sharedPreferences!.getString("email")!),
                    accountName: sharedPreferences!.getString("name")!.isEmpty
                        ? Text("NoName")
                        : Text(sharedPreferences!.getString("name")!),
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
                      backgroundColor: Colors.white,
                      backgroundImage: sharedPreferences!.getString("pic") ==
                              null
                          ? null
                          : NetworkImage(sharedPreferences!.getString("pic")!),
                      child: sharedPreferences!.getString("pic") != null
                          ? null
                          : Icon(
                              Icons.person,
                              size: MediaQuery.of(context).size.width * 0.10,
                              color: const Color(0xFFBF84B1),
                            ),
                    ),
                  ),
                ),
                MenuListWithIcon(
                  icon: Icons.home,
                  title: 'Home',
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (c) => const MainScreenCust()),
                        (Route<dynamic> route) => false);
                  },
                ),
                MenuListWithIcon(
                  icon: Icons.calendar_month,
                  title: 'Schedule',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => const ScheduleTabPage()));
                  },
                ),
                MenuListWithIcon(
                  icon: Icons.history,
                  title: 'History',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => const HistoryTabPage()));
                  },
                ),
                MenuListWithIcon(
                  icon: Icons.chat_bubble,
                  title: 'Chats',
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => ChatsPage()));
                  },
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
