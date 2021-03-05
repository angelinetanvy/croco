import 'package:croco/MapPage.dart';
import 'package:croco/KarmaPage.dart';
import 'package:croco/WalletPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
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
    return SafeArea(
      child: ChangeNotifierProvider(
          create: (_) => MainPageState(),
          builder: (context, child) {
            MainPageState state = context.watch<MainPageState>();
            return Scaffold(
              body: [
                MapPage(),
                WalletPage(null),
                RecyclePage(),
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
            );
          }),
    );
  }
}

class MainPageState with ChangeNotifier {
  int index = 0;
  MainPageState();

  void updateIndex(int newIndex) {
    index = newIndex;
    notifyListeners();
  }
}
