import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hifixit/app/modules/technician/modules/home/controllers/home_controller.dart';
import 'package:hifixit/app/services/global.dart';
import 'package:hifixit/app/widgets/color_pallete.dart';
import 'package:hifixit/app/widgets/marquee_text.dart';
import 'package:hifixit/app/widgets/progress_dialog.dart';

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({Key? key}) : super(key: key);

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  final Completer<GoogleMapController> _gMapController = Completer();

  GoogleMapController? newGoogleMapController;
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  String _currLoc = '';

  List<String> techStatus = ["Available", "Off"];
  String? selectedTechStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection("Technician")
              .doc(currentFirebaseUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            // String selectedTechStatus = snapshot.data!["techStatus"].toString();
            if (!snapshot.hasData) {
              return ProgressDialog(message: "No data");
            }
            return Column(
              children: [
                Text(
                  'Hi ${snapshot.data!["techFName"].toString()},',
                  style: const TextStyle(
                    fontSize: 20,
                    color: const Color(0xFF7B4067),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Text('where are you now?'),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsetsDirectional.only(bottom: 20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    // border: Border.all(width: 2.0, color: Colors.black12),
                    // color: Color(0xFFBF84B1),
                    color: Colors.grey.shade200,
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 250,
                        child: GoogleMap(
                          initialCameraPosition: _kGooglePlex,
                          mapType: MapType.normal,
                          myLocationButtonEnabled: false,
                          myLocationEnabled: true,
                          zoomGesturesEnabled: true,
                          zoomControlsEnabled: true,
                          onMapCreated: (GoogleMapController controller) async {
                            _gMapController.complete(controller);
                            gmapController(controller);
                            _currLoc = await locateTechPosition();
                            setState(() {});
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 300,
                        child: MarqueeWidget(
                          direction: Axis.horizontal,
                          child: Text(
                            _currLoc,
                            style: const TextStyle(
                              // color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFFBF84B1)),
                        ),
                        onPressed: () async {
                          _currLoc = await locateTechPosition();
                        },
                        icon: const Icon(Icons.location_on),
                        label: const Text('Recenter location'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    // border: Border.all(width: 2.0, color: Colors.black12),
                    color: Colors.grey.shade200,
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Status',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF7B4067),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(
                                  0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: DropdownButton(
                          icon: const Icon(
                            Icons.arrow_drop_down_rounded,
                            color: const Color(0xFFEF8A56),
                          ),
                          borderRadius: BorderRadius.circular(20),
                          underline: const SizedBox(),
                          items: techStatus.map((status) {
                            return DropdownMenuItem(
                              child: Text(
                                status,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 15.0,
                                ),
                              ),
                              value: status,
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedTechStatus = newValue.toString();
                              Map<String, dynamic> techStatMap = {
                                "techStatus": selectedTechStatus,
                              };
                              FirebaseFirestore.instance
                                  .collection("Technician")
                                  .doc(currentFirebaseUser!.uid)
                                  .update(techStatMap);
                            });
                          },
                          value: selectedTechStatus,
                          hint: Text(
                            snapshot.data!["techStatus"],
                            style: const TextStyle(
                              fontSize: 15.0,
                              // color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }),
    );
  }
}
