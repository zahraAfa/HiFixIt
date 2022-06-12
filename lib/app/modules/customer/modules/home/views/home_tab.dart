import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hifixit/app/modules/customer/modules/home/controllers/home_controller.dart';
import 'package:hifixit/app/modules/customer/modules/profile/views/profile_tab.dart';
import 'package:hifixit/app/services/global.dart';
import 'package:hifixit/app/widgets/progress_dialog.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
  List<String> priceRange = ["Highest Price", "Lowest Price"];
  String? selectedPriceRange;

  // filtered

  final double _bottomPaddingOfMap = 300;

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

              setState(() {});
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
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 241, 241, 241),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 40,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white,
                            ),
                            child: DropdownButton(
                              icon: const Icon(
                                Icons.arrow_drop_down_rounded,
                                color: Color(0xFFEF8A56),
                              ),
                              underline: const SizedBox(),
                              borderRadius: BorderRadius.circular(20),
                              items: categoryType.map((category) {
                                return DropdownMenuItem(
                                  child: Text(
                                    category,
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      // color: Color(0xFFEF8A56),
                                    ),
                                  ),
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
                                "Choose Category",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 40,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white,
                            ),
                            child: DropdownButton(
                              icon: const Icon(
                                Icons.arrow_drop_down_rounded,
                                color: const Color(0xFFEF8A56),
                              ),
                              underline: const SizedBox(),
                              borderRadius: BorderRadius.circular(20),
                              items: priceRange.map((category) {
                                return DropdownMenuItem(
                                  child: Text(
                                    category,
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      // color: Color(0xFFEF8A56),
                                    ),
                                  ),
                                  value: category,
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedPriceRange = newValue.toString();
                                });
                              },
                              value: selectedPriceRange,
                              hint: const Text(
                                "Price Range",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Technician")
                    .orderBy("techStatus", descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return ProgressDialog(message: "Loading...");
                  }
                  return SizedBox(
                    height: 190,
                    // width: 300,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: snapshot.data!.docs.map((docs) {
                        Map<String, dynamic> data =
                            docs.data()! as Map<String, dynamic>;
                        double distancetech = coordinateDistance(
                            data['latitude'], data['longitude']);
                        if ((10 - distancetech) > 0.0) {
                          //Within 10km
                          return SizedBox(
                            // height: 160,
                            width: 220,
                            child: Card(
                              margin: const EdgeInsets.symmetric(
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
                                              data['techStatus'].toString(),
                                              style: data['techStatus'] == "Off"
                                                  ? const TextStyle(
                                                      color: Colors.grey)
                                                  : const TextStyle(
                                                      color: Colors.green),
                                              textAlign: TextAlign.end,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              Icons.circle,
                                              color: data['techStatus'] == "Off"
                                                  ? Colors.grey
                                                  : Colors.green,
                                              size: 10,
                                            )
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 25,
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 241, 241, 241),
                                            backgroundImage:
                                                data['techPicture'].isEmpty
                                                    ? null
                                                    : NetworkImage(
                                                        data['techPicture']
                                                            .toString()),
                                            child:
                                                data['techPicture'].isNotEmpty
                                                    ? null
                                                    : const Icon(
                                                        Icons
                                                            .account_circle_rounded,
                                                        color: Color.fromARGB(
                                                            255, 156, 156, 156),
                                                        size: 50,
                                                      ),
                                          ),
                                          const SizedBox(
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
                                                    color:
                                                        Colors.grey.shade800),
                                              ),
                                              Text(
                                                data['techCategory'].toString(),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      RatingBar.builder(
                                        ignoreGestures: true,
                                        itemSize: 25,
                                        initialRating:
                                            data['rating'].toDouble(),
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 1.0, vertical: 3.0),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(
                                            onPressed: (() {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (c) =>
                                                          ProfileTabPage(
                                                              techId: data[
                                                                      'techId']
                                                                  .toString())));
                                            }),
                                            child: const Text("Home"),
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        const Color(
                                                            0xFFBF84B1))),
                                          ),
                                          ElevatedButton(
                                            onPressed: (() {}),
                                            child: const Text("Chat"),
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                const Color.fromARGB(
                                                    255, 156, 156, 156),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        } //if
                        return SizedBox();
                      }).toList(),
                    ),
                  );
                }),
          ),
          Positioned(
              bottom: 330,
              right: 15,
              child: FloatingActionButton(
                child: const Icon(Icons.location_on),
                onPressed: () => locateCustPosition(),
              ))
        ],
      ),
    );
  }
}
