import 'package:flutter/material.dart';
import 'package:hifixit/app/modules/technician/modules/history/views/history_tab.dart';
import 'package:hifixit/app/modules/technician/modules/home/views/home_tab.dart';
import 'package:hifixit/app/modules/technician/modules/profile/views/profile_tab.dart';
import 'package:hifixit/app/modules/technician/modules/schedule/views/schedule_tab.dart';
import 'package:hifixit/app/modules/technician/widgets/menu_drawer.dart';

class MainScreenTech extends StatefulWidget {
  const MainScreenTech({Key? key}) : super(key: key);

  @override
  State<MainScreenTech> createState() => _MainScreenTechState();
}

class _MainScreenTechState extends State<MainScreenTech>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TabController? tabController;
  int selectedIndex = 0;

  onItemClicked(int index) {
    setState(() {
      selectedIndex = index;
      tabController!.index = selectedIndex;
    });
  }

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const MenuDrawer(),
      appBar: selectedIndex == 0
          ? AppBar(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              leading: IconButton(
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                icon: const Icon(
                  Icons.menu,
                  color: Color(0xFFEF8A56),
                ),
              ),
            )
          : selectedIndex == 1
              ? AppBar(
                  title: const Text("History"),
                )
              : selectedIndex == 2
                  ? AppBar(
                      title: const Text("Schedule"),
                    )
                  : AppBar(
                      elevation: 0,
                      title: const Text("Your Profile"),
                    ),
      body: TabBarView(
        controller: tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          HomeTabPage(),
          HistoryTabPage(),
          ScheduleTabPage(),
          ProfileTabPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "History",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: "Schedule",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
        unselectedItemColor: const Color(0xFFBF84B1),
        selectedItemColor: const Color(0xFF7B4067),
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontSize: 14),
        showSelectedLabels: true,
        currentIndex: selectedIndex,
        onTap: onItemClicked,
      ),
    );
  }
}
