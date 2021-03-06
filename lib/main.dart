import 'package:croco/Classes/AppUsers.dart';
import 'package:croco/Classes/Goods.dart';
import 'package:croco/Classes/VendingMachine.dart';
import 'package:croco/MapPage.dart';
import 'package:croco/KarmaPage.dart';
import 'package:croco/RecyclePage.dart';
import 'package:croco/WalletPage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

void main() {
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
  AppUsers thisAppUser = AppUsers(
    '1234',
    'Bleiz',
    'btio0002@student.monash.edu',
    10000.0,
    'Hello Me',
    'Gender',
    '2000/10/30',
    [],
    LatLng(
      3.064311,
      101.600882,
    ),
  );

  List<VendingMachine> vendingMachines;
  List<Goods> goods = [
    Goods("Coke", 'SK 124', 2, 2.50, 'assets/images/Coke.jpg'),
    Goods("Sprite", 'SK 125', 1, 2.50, 'assets/images/Sprite.jpg'),
    Goods("A&W", 'SK 1210', 3, 3.50, 'assets/images/AnW.jpg')
  ];

  MainAppState() {
    vendingMachines = [
      VendingMachine("Monash Hive Vending Machine", "0",
          LatLng(3.064431, 101.600582), goods, 10, []),
      VendingMachine("Monash SMR Vending Machine", "1",
          LatLng(3.061441, 101.600682), goods, 20, []),
      VendingMachine("Monash 9305 Vending Machine", "2",
          LatLng(3.061411, 101.600282), goods, 43, []),
      VendingMachine("Rock Cafe Vending Machine", "3",
          LatLng(3.061011, 101.603682), goods, 22, []),
      VendingMachine("Croco Vending Machine", "4", LatLng(3.061888, 101.603888),
          goods, 30, [])
    ];
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
