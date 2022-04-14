import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  List<String> techStatus = ["Available", "Offline"];
  String? selectedTechStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text('Hi NAME,'),
          const Text('where are you now?'),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 250,
            child: GoogleMap(
              initialCameraPosition: _kGooglePlex,
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _gMapController.complete(controller);
                newGoogleMapController = controller;
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Jl. Duku No. 43, Bogor Timur Bogor, West Java 16143, Indonesia?',
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.location_on),
            label: const Text('Change current location'),
          ),
          const SizedBox(
            height: 40,
          ),
          const Text('Status'),
          const SizedBox(
            height: 10,
          ),
          DropdownButton(
            items: techStatus.map((category) {
              return DropdownMenuItem(
                child: Text(
                  category,
                  textAlign: TextAlign.center,
                ),
                value: category,
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedTechStatus = newValue.toString();
              });
            },
            value: selectedTechStatus,
            hint: const Text(
              "Please Choose status",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
