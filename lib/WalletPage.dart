import 'package:croco/Classes/Goods.dart';
import 'package:croco/Classes/PurchasingHistory.dart';
import 'package:croco/PrizePoolCard.dart';
import 'package:croco/WalletCard.dart';
import 'package:croco/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:simple_permissions/simple_permissions.dart';

class WalletPage extends StatelessWidget {
  WalletPage();

  @override
  Widget build(BuildContext context) {
    MainAppState mainState = context.watch<MainAppState>();
    return ChangeNotifierProvider(
      create: (_) => WalletPageState(context, mainState),
      builder: (context, snapshot) {
        WalletPageState state = context.watch<WalletPageState>();
        return Scaffold(
          body: Column(
            children: [
              WalletCard(
                mainState.thisAppUser.balance,
                'Your Wallet',
                "RM",
                Icons.add,
                'Top Up',
                () => state.showTopUpPopUp(context),
              ),
              Expanded(
                child: Container(
                  child: mainState.thisAppUser.userHistory
                              .where((pH) => !pH.hasPickedUp)
                              .toList()
                              .length ==
                          0
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                padding: EdgeInsets.all(20),
                                child: Text("No Items"),
                              ),
                            ),
                          ],
                        )
                      : ListView.builder(
                          itemCount: mainState.thisAppUser.userHistory
                              .where((pH) => !pH.hasPickedUp)
                              .toList()
                              .length,
                          itemBuilder: (context, index) => PickupCard(
                            mainState.thisAppUser.userHistory
                                .where((pH) => !pH.hasPickedUp)
                                .toList()[index],
                          ),
                        ),
                ),
              ),
              CustomButton(state.scanQR, 'SCAN TO COLLECT'),
            ],
          ),
        );
      },
    );
  }
}

class PickupCard extends StatelessWidget {
  final PurchasingHistory purchasingHistory;
  PickupCard(this.purchasingHistory);

  @override
  Widget build(BuildContext context) {
    MainAppState state = context.watch<MainAppState>();
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(10),
        child: ListTile(
          leading: Image.asset(purchasingHistory.goods.image),
          title: Text(purchasingHistory.goods.name),
          subtitle: Text('Awaiting your pickup'),
          trailing: IconButton(
            icon: Icon(Icons.directions),
            onPressed: () {},
          ),
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final onClick;
  final String text;
  CustomButton(this.onClick, this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: CupertinoButton(
        color: Colors.black,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        onPressed: () => onClick(),
      ),
    );
  }
}

class WalletPageState with ChangeNotifier {
  String scanResult;
  BuildContext context;
  MainAppState mainState;
  WalletPageState(this.context, this.mainState);

  void scanQR() async {
    showMatchingPopUp(context);
    bool result = await SimplePermissions.checkPermission(Permission.Camera);
    PermissionStatus status = PermissionStatus.notDetermined;
    if (!result)
      status = await SimplePermissions.requestPermission(Permission.Camera);
    if (result || status == PermissionStatus.authorized)
      scanResult = await scanner.scan();
  }

  void showTopUpPopUp(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text("Choose Amount"),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CupertinoButton(
                  onPressed: () {
                    addMoney(5.0);
                  },
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  color: Colors.grey[600],
                  child: Text("RM 5"),
                ),
                CupertinoButton(
                  onPressed: () => addMoney(10.0),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  color: Colors.grey[700],
                  child: Text("RM 10"),
                ),
                CupertinoButton(
                  onPressed: () => addMoney(20.0),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  color: Colors.grey[800],
                  child: Text("RM 20"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void addMoney(double amount) {
    mainState.updateAppUser(mainState.thisAppUser.updateBalance(amount));
    Navigator.pop(context);
  }

  void showMatchingPopUp(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        color: Colors.white,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PrizePoolCard("123", elevation: 0, show: true),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: ListView.builder(
                    itemCount: mainState.thisAppUser.userHistory
                        .where((pH) => !pH.hasPickedUp)
                        .toList()
                        .length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove_red_eye),
                            onPressed: () {},
                          ),
                          Column(
                            children: [
                              Text("Item ID"),
                              ItemId(
                                (mainState.thisAppUser.userHistory
                                        .where((pH) => !pH.hasPickedUp)
                                        .toList()[index] as PurchasingHistory)
                                    .goods
                                    .goodId,
                                show: false,
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              CustomButton(() {}, 'REVEAL')
            ],
          ),
        ),
      ),
    );
  }
}
