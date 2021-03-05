import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'Goods.dart';

class VendingMachine {
  String name;
  String vendId;
  LatLng coor;
  List<Goods> stocks;
  double distance;

  VendingMachine(this.name, this.vendId, this.coor, this.stocks, this.distance);

  VendingMachine updateMachine(
    String newName,
    LatLng newCoor,
    List<Goods> newStocks,
    double newDistance,
  ) {
    name = newName;
    coor = newCoor;
    stocks = newStocks;
    distance = newDistance;
    return this;
  }

  factory VendingMachine.fromMap(map) {
    return VendingMachine(map['name'], map['vendId'],
        map[LatLng(map['lat'], map['lng'])], map['stocks'], map['distance']);
  }

  toMap() {
    return {
      'name': name,
      'vendId': vendId,
      'latitude': coor.latitude,
      'longitude': coor.longitude,
      'stocks': stocks,
      'distance': distance
    };
  }
}
