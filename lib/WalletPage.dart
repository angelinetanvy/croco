import 'package:croco/WalletCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class WalletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WalletPageState(),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Title"),
          ),
          body: ListView(
            children: [
              WalletCard(
                100,
                'Your Wallet',
                "RM",
                Icons.add,
                'Top Up',
                () {},
              ),
              WalletCard(
                100,
                'Karma Wallet',
                "KP",
                FontAwesomeIcons.recycle,
                'Collect Points',
                () {},
              ),
            ],
          ),
        );
      },
    );
  }
}

class WalletPageState with ChangeNotifier {}
