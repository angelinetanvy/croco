import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecyclePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RecyclePageState(),
      builder: (context, snapshot) {
        return Scaffold();
      },
    );
  }
}

class RecyclePageState with ChangeNotifier {}
