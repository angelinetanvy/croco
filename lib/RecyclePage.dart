import 'package:qrscan/qrscan.dart' as scanner;
import 'package:croco/PrizePoolCard.dart';
import 'package:croco/WalletCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_permissions/simple_permissions.dart';

import 'main.dart';

class KarmaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MainAppState mainState = context.watch<MainAppState>();
    return ChangeNotifierProvider(
      create: (_) => KarmaPageState(),
      builder: (context, child) {
        KarmaPageState karmaPageState = context.watch<KarmaPageState>();
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
                  () {
                    karmaPageState.scanQR();
                  },
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

class KarmaPageState with ChangeNotifier {
  String scanResult;
  void scanQR() async {
    bool result = await SimplePermissions.checkPermission(Permission.Camera);
    PermissionStatus status = PermissionStatus.notDetermined;
    if (!result)
      status = await SimplePermissions.requestPermission(Permission.Camera);
    if (result || status == PermissionStatus.authorized)
      scanResult = await scanner.scan();
  }
}
