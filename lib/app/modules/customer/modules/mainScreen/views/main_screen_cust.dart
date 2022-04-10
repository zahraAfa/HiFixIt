import 'package:flutter/material.dart';
import 'package:hifixit/app/controllers/assistant_method.dart';
import 'package:hifixit/app/modules/customer/modules/history/views/history_tab.dart';
import 'package:hifixit/app/modules/customer/modules/home/views/home_tab.dart';
import 'package:hifixit/app/modules/customer/modules/schedule/views/schedule_tab.dart';
import 'package:hifixit/app/modules/customer/widgets/menu_drawer.dart';

class MainScreenCust extends StatefulWidget {
  const MainScreenCust({Key? key}) : super(key: key);

  @override
  State<MainScreenCust> createState() => _MainScreenCustState();
}

class _MainScreenCustState extends State<MainScreenCust>
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

    tabController = TabController(length: 3, vsync: this);
    AssistantMethod.readCurrentOnlineCustInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: _scaffoldKey,
      drawer: const MenuDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: CircleAvatar(
          radius: 10,
          backgroundColor: Colors.white70,
          child: IconButton(
            visualDensity: VisualDensity.comfortable,
            padding: const EdgeInsets.all(2.0),
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            icon: const Icon(
              Icons.menu,
              color: Color(0xFFEF8A56),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          HomeTabPage(),
          HistoryTabPage(),
          ScheduleTabPage(),
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
