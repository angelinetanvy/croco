import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserLocation {
  Geolocator geolocator = Geolocator();
  LatLng userLocation;

  UserLocation() {
    _determinePosition();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  // void getLocation() async {
  //   Position tempLocation = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.best);
  //   print(tempLocation);

  //   GeolocationStatus geolocationStatus =
  //       await Geolocator().checkGeolocationPermissionStatus();
  //   print(geolocationStatus);
  //   userLocation = LatLng(tempLocation.latitude, tempLocation.longitude);
  // }

  Future<double> getDistance(double lat, double long) async {
    Position x = await _determinePosition();
    return Geolocator.distanceBetween(x.latitude, x.longitude, lat, long);
  }
}
