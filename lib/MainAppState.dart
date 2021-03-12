import 'dart:math' show cos, sqrt, asin;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:croco/Classes/AppUsers.dart';
import 'package:croco/Classes/VendingMachine.dart';
import 'package:croco/Firebase.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MainAppState with ChangeNotifier {
  FlutterLocalNotificationsPlugin localNotif;

  void initState() {
    var androidInitialize =
        new AndroidInitializationSettings('ic_launcher.png');
    var iOSInitialize = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: androidInitialize, iOS: iOSInitialize);

    localNotif = new FlutterLocalNotificationsPlugin();
    localNotif.initialize(initializationSettings);
  }

  Future _showNotification() async {
    var androidInitialize = new AndroidInitializationSettings('@mipmap/logo');
    var iOSInitialize = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: androidInitialize, iOS: iOSInitialize);

    localNotif = new FlutterLocalNotificationsPlugin();
    localNotif.initialize(initializationSettings);
    var androidDetails = new AndroidNotificationDetails(
        "channelId", "channelName", "There is a vending machine nearby!",
        importance: Importance.high);
    var iosDetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iosDetails);
    await localNotif.show(0, "Feeling thirsty?",
        "There is a vending machine nearby!", generalNotificationDetails);
  }

  int index = 0;
  double cashPool;
  String prizeId = "SK1234343145";
  AppUsers thisAppUser;
  List<VendingMachine> vendingMachines = [];
  var location = Location();

  MainAppState() {
    FirebaseClass().vendingMachineListStream((VendingMachine vending) {
      updateVendingMachineList(
        (v) {
          v.add(vending);
          return v;
        },
      );
    });
    getLocation();
    listenToPricePool();
  }

  getLocation() {
    location.getLocation().asStream().listen(
      (LocationData coor) {
        vendingMachines.forEach((VendingMachine vM) {
          if (calculateDistance(
                  LatLng(coor.latitude, coor.longitude), vM.coor) <=
              1000) {
            _showNotification();
          }
        });
      },
    );
  }

  listenToPricePool() {
    FirebaseFirestore.instance
        .collection("pricepool")
        .doc("pricepool")
        .snapshots()
        .listen((event) {
      cashPool = (event.data()['pricepool']).toDouble();
      notifyListeners();
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
