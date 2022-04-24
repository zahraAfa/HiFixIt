import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hifixit/app/services/global.dart';

class TechHomeController {}

Position? techCurrentPosition;
var geoLocator = Geolocator();
List<Placemark>? placeMarks;
String techCompleteAddress = '';

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

locateTechPosition() async {
  Position currPosition = await _determinePosition();
  techCurrentPosition = currPosition;

  LatLng latLngPosition =
      LatLng(techCurrentPosition!.latitude, techCurrentPosition!.longitude);

// To get the address

  placeMarks = await placemarkFromCoordinates(
      techCurrentPosition!.latitude, techCurrentPosition!.longitude);

  String techCompleteAddress =
      '${placeMarks![0].street}, ${placeMarks![0].subLocality} ${placeMarks![0].locality}, ${placeMarks![0].administrativeArea} ${placeMarks![0].postalCode}, ${placeMarks![0].country}';

  CameraPosition cameraPosition =
      CameraPosition(target: latLngPosition, zoom: 18);

  newGoogleMapController!
      .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

  Map<String, dynamic> techNewMap = {
    "latitude": techCurrentPosition!.latitude,
    "longitude": techCurrentPosition!.longitude,
    "currLocation": techCompleteAddress,
  };

  FirebaseFirestore.instance
      .collection("Technician")
      .doc(currentFirebaseUser!.uid)
      .update(techNewMap);

  return techCompleteAddress;
}
