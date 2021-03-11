import 'dart:math';
import 'package:croco/Classes/AppUsers.dart';
import 'package:croco/Classes/Goods.dart';
import 'package:croco/Classes/VendingMachine.dart';
import 'package:croco/Firebase.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MainAppState with ChangeNotifier {
  int index = 0;
  double cashPool = 0;
  String prizeId = "SK12343434";
  AppUsers thisAppUser;

  List<VendingMachine> vendingMachines = [];

  MainAppState() {
    FirebaseClass().vendingMachineListStream((VendingMachine vending) {
      updateVendingMachineList(
        (v) {
          v.add(vending);
          return v;
        },
      );
    });
  }

  double calculateDistance(LatLng pos1, LatLng pos2) {
    var lat1 = pos1.latitude;
    var lon1 = pos1.longitude;
    var lat2 = pos2.latitude;
    var lon2 = pos2.longitude;
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return double.parse((12742 * asin(sqrt(a)) * 100).toStringAsPrecision(2));
  }

  void updateCashPool(double updateBy) {
    cashPool += updateBy;
    notifyListeners();
  }

  void updateIndex(int newIndex) {
    index = newIndex;
    notifyListeners();
  }

  void updateAppUser(AppUsers appUser) {
    thisAppUser = appUser;
    FirebaseClass().updatesUserInFirebase(appUser.userId, appUser);
    notifyListeners();
  }

  void updateVendingMachineList(
    List<VendingMachine> Function(List<VendingMachine>) callback,
  ) {
    vendingMachines = callback(vendingMachines);
    notifyListeners();
  }
}
