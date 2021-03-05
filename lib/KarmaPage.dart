import 'package:croco/WalletCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecyclePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RecyclePageState(),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Title"),
          ),
          body: Column(
            children: [
              WalletCard(
                100,
                'Karma Points',
                "KP",
                Icons.event_note,
                'Collect Karma Points',
                () {},
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Expanded(
                  child: Card(
                    elevation: 2,
                    child: Container(),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class RecyclePageState with ChangeNotifier {}
