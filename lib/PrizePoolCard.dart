import 'package:croco/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrizePoolCard extends StatelessWidget {
  final double elevation;
  final String itemId;
  PrizePoolCard(this.itemId, {this.elevation = 2});
  @override
  Widget build(BuildContext context) {
    MainAppState state = context.watch<MainAppState>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Card(
              elevation: elevation,
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Current Prize Pool',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'RM',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            state.cashPool.toStringAsFixed(2),
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Image(
                        image: NetworkImage(
                          "https://cdn.discordapp.com/attachments/811098272076398642/817567929528352818/gold_pile.gif",
                        ),
                      ),
                    ),
                    ItemId(itemId)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemId extends StatelessWidget {
  final String id;
  ItemId(this.id);
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
                  future:
                      Future.delayed(Duration(milliseconds: 500 + i * 500), () {
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
