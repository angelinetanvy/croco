import 'package:croco/AppLoginPage.dart';

import 'package:croco/MainAppState.dart';
import 'package:croco/MapPage.dart';
import 'package:croco/RecyclePage.dart';
import 'package:croco/WalletPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
    MainAppState state = context.watch<MainAppState>();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: state.thisAppUser == null ? AppLoginPage() : MainPage(),
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
      ),
    );
  }
}
