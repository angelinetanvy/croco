import 'package:croco/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class PrizePoolCard extends StatelessWidget {
  final double elevation;
  final String itemId;
  final bool show;
  PrizePoolCard(this.itemId, {this.elevation = 2,this.show = false});
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: Text('Prize ID'),
                        ),
                        ItemId(state.prizeId, show: show),
                      ],
                    ),
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

class ItemId extends StatefulWidget {
  final String id;
  final bool show;
  ItemId(this.id, {this.show = false});

  @override
  _ItemIdState createState() => _ItemIdState();
}

class _ItemIdState extends State<ItemId> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  // @override
  // void initState() {
  //   super.initState();
  //   _controller = AnimationController(
  //       duration: Duration(milliseconds: 2000), value: this);
  //   _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          for (int i = 0; i < widget.id.length; i++)
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
                      Duration(milliseconds: widget.show ? 0 : 1000 + i * 1000),
                      () {
                    return true;
                  }),
                  builder: (context, snapshot) {
                    return AnimatedOpacity(
                      opacity: snapshot.hasData ? 1 : 0,
                      duration: Duration(milliseconds: 500),
                      child: Text(
                        widget.id[i],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                    // _controller.forward();
                    // return AnimatedBuilder(
                    //   animation: _controller,
                    //   builder: (BuildContext context, Widget child) {
                    //     bool isFront = _controller.value < .5;
                    //     return Transform(
                    //       transform: Matrix4.identity()
                    //         ..setEntry(3, 2, 0.002)
                    //         ..rotateX(
                    //             pi * _animation.value + (isFront ? 0 : pi)),
                    //       alignment: FractionalOffset.center,
                    //       child: isFront ? Text("  ") : Text(widget.id[i]),
                    //     );
                    //   },
                    // );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
