import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hifixit/app/services/global.dart';
import 'dart:math' show cos, sqrt, asin;

Position? custCurrentPosition;
var geoLocator = Geolocator();
List<Placemark>? placeMarks;
String custCompleteAddress = '';

// double totalDistance = 0.0; //km

GoogleMapController? newGoogleMapController;

gmapController(c) {
  newGoogleMapController = c;
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
}

locateCustPosition() async {
  Position currPosition = await _determinePosition();
  custCurrentPosition = currPosition;

  LatLng latLngPosition =
      LatLng(custCurrentPosition!.latitude, custCurrentPosition!.longitude);

// To get the address
  placeMarks = await placemarkFromCoordinates(
      custCurrentPosition!.latitude, custCurrentPosition!.longitude);

  String custCompleteAddress =
      '${placeMarks![0].street}, ${placeMarks![0].subLocality} ${placeMarks![0].locality}, ${placeMarks![0].administrativeArea} ${placeMarks![0].postalCode}, ${placeMarks![0].country}';

  CameraPosition cameraPosition =
      CameraPosition(target: latLngPosition, zoom: 18);

  newGoogleMapController!
      .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

  Map<String, dynamic> custNewMap = {
    "latitude": custCurrentPosition!.latitude,
    "longitude": custCurrentPosition!.longitude,
    "currLocation": custCompleteAddress,
  };

  FirebaseFirestore.instance
      .collection("Customer")
      .doc(currentFirebaseUser!.uid)
      .update(custNewMap);

  return custCompleteAddress;
}

double coordinateDistance(lat, lon) {
  double? latCur = custCurrentPosition?.latitude;
  double? lonCur = custCurrentPosition?.longitude;
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat - latCur) * p) / 2 +
      c(latCur! * p) * c(lat * p) * (1 - c((lon - lonCur) * p)) / 2;
  // print((127420 * asin(sqrt(a))).toStringAsFixed(3));
  return 12742 * asin(sqrt(a));
}
