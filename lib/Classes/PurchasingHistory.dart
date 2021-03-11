import 'package:croco/Classes/Goods.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PurchasingHistory {
  final int purchasingId;
  final String vendId;
  final String userId;
  final String vendingName;
  final LatLng vendingLocation;
  final Goods goods;
  final bool hasPickedUp;
  int purchaseDate;

  PurchasingHistory(this.purchasingId, this.vendId, this.userId,
      this.hasPickedUp, this.vendingName, this.vendingLocation, this.goods,
      {this.purchaseDate}) {
    if (purchaseDate == null)
      purchaseDate = DateTime.now().millisecondsSinceEpoch;
  }

  factory PurchasingHistory.frommap(map) {
    return PurchasingHistory(
      map['purchasingId'],
      map['vendId'],
      map['userId'],
      map['hasPickedUp'],
      map['vendingName'],
      LatLng(map['vendingLat'], map['vendingLong']),
      Goods.fromMap(map['goods']),
      purchaseDate: map['purchaseDate'],
    );
  }

  toMap() {
    return {
      'purchasingId': purchasingId,
      'vendId': vendId,
      'userId': userId,
      'hasPickedUp': hasPickedUp,
      'purchaseDate': purchaseDate,
      'vendingName': vendingName,
      'vendingLat': vendingLocation.latitude,
      'vendingLong': vendingLocation.longitude,
      'goods': goods.toMap(),
    };
  }
}
