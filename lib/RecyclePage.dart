import 'package:croco/PrizePoolCard.dart';
import 'package:croco/WalletCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KarmaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => KarmaPageState(),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Luck of the Draw"),
          ),
          body: Container(
            child: Column(
              children: [
                WalletCard(
                  100,
                  'Karma Points',
                  "KP",
                  Icons.event_note,
                  'Collect Karma Points',
                  () {},
                ),
                PrizePoolCard('SK1242dh123'),
              ],
            ),
          ),
        );
      },
    );
  }
}

class KarmaPageState with ChangeNotifier {}
