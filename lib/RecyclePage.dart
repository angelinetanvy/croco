import 'package:croco/PrizePoolCard.dart';
import 'package:croco/WalletCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class KarmaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MainAppState mainState = context.watch<MainAppState>();
    return ChangeNotifierProvider(
      create: (_) => KarmaPageState(),
      builder: (context, child) {
        return Scaffold(
          body: Container(
            child: Column(
              children: [
                WalletCard(
                  mainState.thisAppUser.points,
                  'Karma Points',
                  "KP",
                  Icons.event_note,
                  'Collect Karma Points',
                  () {},
                ),
                PrizePoolCard('SK1242dh123', show: true),
              ],
            ),
          ),
        );
      },
    );
  }
}

class KarmaPageState with ChangeNotifier {}
