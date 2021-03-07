import 'package:croco/Classes/Goods.dart';
import 'package:croco/Classes/PurchasingHistory.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
      (map['stocks'] as List).map((data) => Goods.fromMap(data)).toList(),
      map['distance'],
      (map['purchasedGoods'] as List)
          .map((data) => PurchasingHistory.frommap(data))
          .toList(),
    );
  }

  toMap() {
    return {
      'name': name,
      'vendId': vendId,
      'lat': coor.latitude,
      'lng': coor.longitude,
      'stocks': stocks.map((Goods g) => g.toMap()).toList(),
      'distance': distance,
      'purchasedGoods':
          purchasedGoods.map((PurchasingHistory pH) => pH.toMap()).toList(),
    };
  }
}
