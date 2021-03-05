import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppLocations {
  final LatLng coor;
  int time;

  AppLocations(this.coor, {time}) {
    if (time == null) time = DateTime.now().millisecondsSinceEpoch;
  }

  factory AppLocations.fromMap(map) {
    return AppLocations(LatLng(map['lat'], map['long']), time: map['time']);
  }

  toMap() {
    return {'time': time, 'lat': coor.latitude, 'long': coor.longitude};
  }
}
