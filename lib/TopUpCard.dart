import 'package:croco/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopUpCard extends StatelessWidget {
  final double elevation;
  final String itemId;
  TopUpCard(this.itemId, {this.elevation = 2});
  @override
  Widget build(BuildContext context) {
    MainAppState state = context.watch<MainAppState>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }
}

class ItemId extends StatelessWidget {
  final String id;
  final bool show;
  ItemId(this.id, {this.show = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          for (int i = 0; i < id.length; i++)
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(3),
                ),
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder(
                  future: Future.delayed(
                      Duration(milliseconds: show ? 0 : 500 + i * 500), () {
                    return true;
                  }),
                  builder: (context, snapshot) {
                    return AnimatedOpacity(
                      opacity: snapshot.hasData ? 1 : 0,
                      duration: Duration(milliseconds: 500),
                      child: Text(
                        id[i],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
