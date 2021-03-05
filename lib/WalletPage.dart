import 'package:croco/Classes/PurchasingHistory.dart';
import 'package:croco/WalletCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:simple_permissions/simple_permissions.dart';

class WalletPage extends StatelessWidget {
  PurchasingHistory purchaseHis;

  WalletPage(this.purchaseHis);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WalletPageState(),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Title"),
            centerTitle: false,
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
              purchaseHis == null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Text("No Item"),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Text("Awaiting your pickup"),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
              Container(
                padding: EdgeInsets.all(10),
                child: CupertinoButton(
                  color: Colors.black,
                  child: Text(
                    "SCAN",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  onPressed: () => scanQR(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

void scanQR() async {
  bool result = await SimplePermissions.checkPermission(Permission.Camera);
  PermissionStatus status = PermissionStatus.notDetermined;
  if (!result) {
    status = await SimplePermissions.requestPermission(Permission.Camera);
  }
  if (result || status == PermissionStatus.authorized) {
    String scanResult = await scanner.scan();
  }
}

class WalletPageState with ChangeNotifier {}
