import 'package:flutter/material.dart';
import 'package:hifixit/technician/pages/tabPages/history_tab.dart';
import 'package:hifixit/technician/pages/tabPages/home_tab.dart';
import 'package:hifixit/technician/pages/tabPages/profile_tab.dart';
import 'package:hifixit/technician/pages/tabPages/schedule_tab.dart';

class MainScreenTech extends StatefulWidget {
  const MainScreenTech({Key? key}) : super(key: key);

  @override
  State<MainScreenTech> createState() => _MainScreenTechState();
}

class _MainScreenTechState extends State<MainScreenTech>
    with SingleTickerProviderStateMixin {
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
