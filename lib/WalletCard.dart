import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WalletCard extends StatelessWidget {
  final double value;
  final String unit;
  final String title;
  final IconData actionIcon;
  final String actionLable;
  final Function actionFunction;
  const WalletCard(
    this.value,
    this.title,
    this.unit,
    this.actionIcon,
    this.actionLable,
    this.actionFunction,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 2,
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  title,
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
                      unit,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      value.toString(),
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              CupertinoButton(
                padding: EdgeInsets.all(0),
                onPressed: () => actionFunction(),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(actionIcon),
                    ),
                    Text(actionLable)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
