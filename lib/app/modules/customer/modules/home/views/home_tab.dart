import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hifixit/app/modules/customer/modules/home/controllers/home_controller.dart';
import 'package:hifixit/app/services/global.dart';
import 'package:hifixit/app/widgets/progress_dialog.dart';

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({Key? key}) : super(key: key);

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  final Completer<GoogleMapController> _gMapController = Completer();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  String _currLoc = '';

  double searchLocationContainerHeight = 320;

  List<String> categoryType = ["Washing Machine", "Air Conditioner"];
  String? selectedCategoryType;

  double _bottomPaddingOfMap = 0;
  int _index = 4;

  // searchCategoryInfo() {
  //   Map techCategoryMap = {
  //     "category": selectedCategoryType,
  //   };
  //   DatabaseReference techRef =
  //       FirebaseDatabase.instance.ref().child("Customer");
  //   // techRef
  //   //     .child(currentFirebaseUser!.uid)
  //   //     .child("TechCategory")
  //   //     .set(techCategoryMap);

  //   Fluttertoast.showToast(msg: "Searching...");
  //   // Navigator.push(
  //   //     context, MaterialPageRoute(builder: (c) => const MySplashScreen()));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: _bottomPaddingOfMap),
            initialCameraPosition: _kGooglePlex,
            mapType: MapType.normal,
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            onMapCreated: (GoogleMapController controller) async {
              _gMapController.complete(controller);
              gmapController(controller);
              _currLoc = await locateCustPosition();

              setState(() {
                _bottomPaddingOfMap = 300;
              });
            },
          ),
          Positioned(
            bottom: 0,
            left: 20,
            right: 20,
            child: AnimatedSize(
              duration: const Duration(milliseconds: 120),
              curve: Curves.easeIn,
              child: Container(
                height: searchLocationContainerHeight,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 241, 241, 241),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  child: Column(
                    children: [
                      DropdownButton(
                        items: categoryType.map((category) {
                          return DropdownMenuItem(
                            child: Text(category),
                            value: category,
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedCategoryType = newValue.toString();
                          });
                        },
                        value: selectedCategoryType,
                        hint: const Text(
                          "Please Choose Category",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Technician")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return ProgressDialog(message: "No data");
                  }
                  return SizedBox(
                    height: 180,
                    // width: 300,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: snapshot.data!.docs.map((docs) {
                        Map<String, dynamic> data =
                            docs.data()! as Map<String, dynamic>;
                        return SizedBox(
                          // height: 160,
                          width: 220,
                          child: Card(
                            margin: EdgeInsets.symmetric(
                                horizontal: 13, vertical: 5),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            'Available',
                                            style:
                                                TextStyle(color: Colors.green),
                                            textAlign: TextAlign.end,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Icon(
                                            Icons.circle,
                                            color: Colors.green,
                                            size: 10,
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 25,
                                          backgroundColor: Color.fromARGB(
                                              255, 235, 235, 235),
                                          backgroundImage: NetworkImage(
                                              data['techPicture'].toString()),
                                          child: data['techPicture'].isNotEmpty
                                              ? null
                                              : Icon(
                                                  Icons.account_circle_rounded,
                                                  color: Colors.grey,
                                                  size: 50,
                                                ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data['techFName'].toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.grey.shade800),
                                            ),
                                            Text(
                                                data['techCategory'].toString())
                                          ],
                                        )
                                      ],
                                    ),
                                    Center(
                                      child: Text(
                                        data['techFName'].toString(),
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }),
          ),
          Positioned(
              bottom: 330,
              right: 15,
              child: FloatingActionButton(
                child: Icon(Icons.location_on),
                onPressed: () => locateCustPosition(),
              ))
        ],
      ),
    );
  }
}
