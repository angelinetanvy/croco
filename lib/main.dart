import 'dart:math';

import 'package:croco/AppLoginPage.dart';
import 'package:croco/Classes/AppUsers.dart';
import 'package:croco/Classes/Goods.dart';
import 'package:croco/Classes/VendingMachine.dart';
import 'package:croco/MapPage.dart';
import 'package:croco/RecyclePage.dart';
import 'package:croco/WalletPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (_) => MainAppState(),
      builder: (context, snapshot) {
        return MyApp();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MainAppState state = context.watch<MainAppState>();
    return SafeArea(
        child: Scaffold(
      body: [
        MapPage(),
        WalletPage(),
        KarmaPage(),
      ][state.index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: state.index,
        onTap: state.updateIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: "Map",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet_membership),
            label: "Wallet",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note),
            label: "Recycle",
          ),
        ],
      ),
    ));
  }
}

class MainAppState with ChangeNotifier {
  int index = 0;
  double cashPool = 0;
  String prizeId = "SK12343434";
  AppUsers thisAppUser = AppUsers(
    '1234',
    'Bleiz',
    'btio0002@student.monash.edu',
    100.0,
    'Hello Me',
    'Gender',
    '2000/10/30',
    [],
    LatLng(3.0652, 101.6019),
    100,
  );

  List<VendingMachine> vendingMachines;
  List<Goods> goods = [
    Goods("Pepsi", 'SK12443434', 2, 2.50, 'assets/images/Pepsi.png'),
    Goods("Sprite", 'SK12343434', 1, 2.50, 'assets/images/Sprite.jpg'),
    Goods("A&W", 'SKSK12353434', 3, 3.50, 'assets/images/AnW.jpg'),
    Goods("Fanta", 'SKSK13353434', 3, 3.50, 'assets/images/FantaOrange.png')
  ];

  MainAppState() {
    vendingMachines = [
      VendingMachine(
          "Monash Hive Vending Machine",
          "0",
          LatLng(3.064431, 101.600582),
          goods,
          calculateDistance(
            thisAppUser.location,
            LatLng(
              3.064431,
              101.600582,
            ),
          ),
          []),
      VendingMachine(
          "Monash SMR Vending Machine",
          "1",
          LatLng(3.061441, 101.600682),
          goods,
          calculateDistance(
            thisAppUser.location,
            LatLng(3.061441, 101.600682),
          ),
          []),
      VendingMachine(
          "Monash 9305 Vending Machine",
          "2",
          LatLng(3.061411, 101.600282),
          goods,
          calculateDistance(
            thisAppUser.location,
            LatLng(3.061411, 101.600282),
          ),
          []),
      VendingMachine(
          "Rock Cafe Vending Machine",
          "3",
          LatLng(3.061011, 101.603682),
          goods,
          calculateDistance(
            thisAppUser.location,
            LatLng(3.061011, 101.603682),
          ),
          []),
      VendingMachine(
        "Croco Vending Machine",
        "4",
        LatLng(3.061888, 101.603888),
        goods,
        calculateDistance(
          thisAppUser.location,
          LatLng(3.061888, 101.603888),
        ),
        [],
      )
    ];
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
    notifyListeners();
  }

  void updateVendingMachineList(
      List<VendingMachine> Function(List<VendingMachine>) callback) {
    vendingMachines = callback(vendingMachines);
    notifyListeners();
  }
}
