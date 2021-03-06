import 'package:croco/Classes/PurchasingHistory.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Classes/VendingMachine.dart';
import 'Classes/Goods.dart';
import 'main.dart';

class CheckoutPage extends StatelessWidget {
  final VendingMachine vM;
  final Goods goods;

  CheckoutPage(this.vM, this.goods);

  @override
  Widget build(BuildContext context) {
    MainAppState mainState = context.watch<MainAppState>();
    return ChangeNotifierProvider(
      create: (_) => CheckOutPageState(context),
      builder: (context, snapshot) {
        CheckOutPageState state = context.watch<CheckOutPageState>();
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                ListTile(
                  title: Text(vM.name),
                  subtitle: Text(vM.distance.toString() + " m"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Image.asset(
                          goods.image,
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  goods.name,
                                  style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "RM" + goods.price.toString(),
                                  style: TextStyle(fontSize: 30),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: Text(
                    "Purchase Methods",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: ListView.builder(
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          onTap: () => state.onPurchase(
                            mainState,
                            vM,
                            goods,
                            context,
                          ),
                          title: Text([
                            'Croco-Wallet',
                            'Credit Card',
                            'Cash Payment',
                          ][index]),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CheckOutPageState with ChangeNotifier {
  BuildContext buildContext;
  CheckOutPageState(this.buildContext);

  onPurchase(
    MainAppState mainState,
    VendingMachine vM,
    Goods goods,
    BuildContext context,
  ) {
    int date = DateTime.now().millisecondsSinceEpoch;

    PurchasingHistory pH = new PurchasingHistory(
      date,
      vM.vendId,
      mainState.thisAppUser.userId,
      false,
      vM.name,
      vM.coor,
      Goods(goods.name, goods.goodId, 1, goods.price, goods.image),
      purchaseDate: date,
    );

    mainState.updateAppUser(
      mainState.thisAppUser
          .updateBalance(-goods.price)
          .updatePurchasingHistory((List<dynamic> ls) {
        ls.add(pH);
        return ls;
      }),
    );

    mainState.updateVendingMachineList(
      (List<VendingMachine> list) => list.map(
        (VendingMachine vendingMachine) {
          return vendingMachine.vendId == vM.vendId
              ? vM.updateStockNum(goods, -1).updatePurchasingHistory((List ls) {
                  ls.add(pH);
                  return ls;
                })
              : vendingMachine;
        },
      ).toList(),
    );

    mainState.updateCashPool(goods.price * 0.02);

    mainState.updateIndex(1);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainPage(),
      ),
    );
  }
}
