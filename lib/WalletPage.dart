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
      create: (_) => WalletPageState(context),
      builder: (context, snapshot) {
        WalletPageState state = context.watch<WalletPageState>();
        return Scaffold(
          appBar: AppBar(
            title: Text("Title"),
            centerTitle: false,
          ),
          body: Column(
            children: [
              WalletCard(
                mainState.thisAppUser.balance,
                'Your Wallet',
                "RM",
                Icons.add,
                'Top Up',
                () {},
              ),
              Expanded(
                child: Container(
                  child: mainState.thisAppUser.userHistory
                              .where((pH) => !pH.hasPickedUp)
                              .toList()
                              .length ==
                          0
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
              CustomButton(state.scanQR, 'S C A N'),
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
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.all(10),
        child: ListTile(
          leading: Image.asset(purchasingHistory.goods.image),
          title: Text(purchasingHistory.goods.name),
          subtitle: Text('Awaiting your pickup'),
          trailing: Text(""),
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
  WalletPageState(this.context);

  void scanQR() async {
    showMatchingPopUp(context);
    // bool result = await SimplePermissions.checkPermission(Permission.Camera);
    // PermissionStatus status = PermissionStatus.notDetermined;
    // if (!result)
    //   status = await SimplePermissions.requestPermission(Permission.Camera);
    // if (result || status == PermissionStatus.authorized)
    //   scanResult = await scanner.scan();
  }

  void showTopUpPopUp(BuildContext context) {
    showModalBottomSheet(context: context, builder: (context) => Container());
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PrizePoolCard(
                    "123",
                    elevation: 0,
                  ),
                  CustomButton(() {}, 'REVEAL')
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
