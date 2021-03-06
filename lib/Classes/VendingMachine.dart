import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'Goods.dart';
import 'PurchasingHistory.dart';

class VendingMachine {
  String name;
  String vendId;
  LatLng coor;
  List<Goods> stocks;
  List<PurchasingHistory> purchasedGoods;
  double distance;

  VendingMachine(
    this.name,
    this.vendId,
    this.coor,
    this.stocks,
    this.distance,
    this.purchasedGoods,
  ) {
    if (this.stocks == null) this.stocks = [];
    if (this.purchasedGoods == null) this.purchasedGoods = [];
  }

  VendingMachine updateStocks(List<Goods> newStocks) {
    stocks = newStocks;
    return this;
  }

  VendingMachine updatePurchasingHistory(
      List<PurchasingHistory> Function(List<PurchasingHistory>) callback) {
    purchasedGoods = callback(purchasedGoods);
    return this;
  }

  VendingMachine updateStockNum(Goods good, int removeNum) {
    stocks = stocks
        .map((Goods thisGoods) => thisGoods.goodId == good.goodId
            ? good.upgradeGoodsQuantity(removeNum)
            : thisGoods)
        .toList();
    return this;
  }

  bool checkAvalibility(Goods good) {
    bool retval = false;
    this.stocks.forEach((goods) {
      if ((goods.name == good.name) && goods.stock > 0) {
        retval = true;
      }
    });
    return retval;
  }

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
    return VendingMachine(
      map['name'],
      map['vendId'],
      map[LatLng(map['lat'], map['lng'])],
      map['stocks'],
      map['distance'],
      map['purchasedGoods'],
    );
  }

  toMap() {
    return {
      'name': name,
      'vendId': vendId,
      'latitude': coor.latitude,
      'longitude': coor.longitude,
      'stocks': stocks,
      'distance': distance,
      'purchasedGoods': purchasedGoods,
    };
  }
}
