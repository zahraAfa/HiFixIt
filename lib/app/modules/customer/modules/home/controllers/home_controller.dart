import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Position? custCurrentPosition;
var geoLocator = Geolocator();

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

  CameraPosition cameraPosition =
      CameraPosition(target: latLngPosition, zoom: 16);

  newGoogleMapController!
      .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
}
