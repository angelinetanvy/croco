import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserLocation {
  Geolocator geolocator = Geolocator();
  LatLng userLocation;

  UserLocation() {
    getLocation();
  }

  void getLocation() async {
    Position tempLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    userLocation = LatLng(tempLocation.latitude, tempLocation.longitude);
  }

  double getDistance(double lat, double long) {
    return Geolocator.distanceBetween(
        userLocation.latitude, userLocation.longitude, lat, long);
  }
}
