import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Position? custCurrentPosition;
var geoLocator = Geolocator();
List<Placemark>? placeMarks;
String custCompleteAddress = '';

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
  placemarkFromCoordinates(
          custCurrentPosition!.latitude, custCurrentPosition!.longitude)
      .then((pm) {
    print('No results found.');
    if (pm.isNotEmpty) {
      print(pm[0].toString());
      custCompleteAddress =
          '${pm[0].street}, ${pm[0].subLocality} ${pm[0].locality}, ${pm[0].administrativeArea} ${pm[0].postalCode}, ${pm[0].country}';
      print(custCompleteAddress);
    }
  });

  // Placemark custPMark = placeMarks![0];

  // String custCompleteAddress =
  //     '${custPMark.subThoroughfare} ${custPMark.thoroughfare}, ${custPMark.subLocality} ${custPMark.locality}, ${custPMark.subAdministrativeArea}, ${custPMark.administrativeArea} ${custPMark.postalCode}, ${custPMark.country}';

  // print(custCompleteAddress);

  CameraPosition cameraPosition =
      CameraPosition(target: latLngPosition, zoom: 18);

  newGoogleMapController!
      .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
}
