import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hifixit/app/modules/customer/modules/home/controllers/home_controller.dart';
import 'package:hifixit/app/modules/customer/modules/home/views/home_tab.dart';
import 'package:hifixit/app/modules/customer/widgets/menu_drawer.dart';
import 'package:hifixit/app/services/global.dart';
import 'package:hifixit/app/widgets/marquee_text.dart';

class MainScreenCust extends StatefulWidget {
  const MainScreenCust({Key? key}) : super(key: key);

  @override
  State<MainScreenCust> createState() => _MainScreenCustState();
}

class _MainScreenCustState extends State<MainScreenCust>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: _scaffoldKey,
      drawer: MenuDrawer(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: Material(
          borderRadius: BorderRadius.circular(30),
          elevation: 2,
          child: CircleAvatar(
            radius: 10,
            backgroundColor: Colors.white,
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
        title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          width: 270,
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            children: [
              Icon(
                Icons.add_location_alt,
                color: Color(0xFFEF8A56),
              ),
              SizedBox(
                width: 10,
              ),
              StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection("Customer")
                    .doc(currentFirebaseUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.connectionState ==
                          ConnectionState.active ||
                      snapshot.connectionState == ConnectionState.done) {
                    return SizedBox(
                      width: 210,
                      child: MarqueeWidget(
                        direction: Axis.horizontal,
                        child: Text(
                          snapshot.data!["currLocation"],
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
        ),
      ),
      body: const HomeTabPage(),
    );
  }
}
