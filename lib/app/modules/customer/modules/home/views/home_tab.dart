import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hifixit/app/modules/customer/modules/home/controllers/home_controller.dart';

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

  double searchLocationContainerHeight = 220;

  List<String> categoryType = ["Washing Machine", "Air Conditioner"];
  String? selectedCategoryType;

  double _bottomPaddingOfMap = 0;

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
                _bottomPaddingOfMap = 200;
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
                  color: Colors.white,
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
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Search Technician"),
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFFBF84B1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 230,
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
