import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hifixit/app/modules/customer/modules/home/views/home_tab.dart';
import 'package:hifixit/app/modules/customer/widgets/menu_drawer.dart';

class MainScreenCust extends StatefulWidget {
  const MainScreenCust({Key? key}) : super(key: key);

  @override
  State<MainScreenCust> createState() => _MainScreenCustState();
}

class _MainScreenCustState extends State<MainScreenCust>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // TabController? tabController;
  // int selectedIndex = 0;

  // onItemClicked(int index) {
  //   setState(() {
  //     selectedIndex = index;
  //     // tabController!.index = selectedIndex;
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();

  //   tabController = TabController(length: 3, vsync: this);
  //   AssistantMethod.readCurrentOnlineCustInfo();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: _scaffoldKey,
      drawer: MenuDrawer(),
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
        title: Row(
          children: const [
            Icon(
              Icons.add_location_alt,
              color: Color(0xFFEF8A56),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              "Current Location",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            )
          ],
        ),
      ),
      body: const HomeTabPage(),
    );
  }
}
