import 'package:croco/Classes/PurchasingHistory.dart';
import 'package:croco/RoutingPage.dart';
import 'package:flutter/cupertino.dart';
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  goods.name,
                                  softWrap: false,
                                  style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "RM" + goods.price.toString(),
                                  style: TextStyle(fontSize: 20),
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
                          onTap: () {
                            if (index == 0) {
                              state.onPurchase(
                                  mainState, vM, goods, context, 0.0);
                            } else if (index == 1) {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        title: Text("Select Voucher"),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          CupertinoButton(
                                            onPressed: () {
                                              state.onPurchase(mainState, vM,
                                                  goods, context, 1.0);
                                            },
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 30),
                                            color: Colors.grey[600],
                                            child: Column(
                                              children: [
                                                Text("- RM 1"),
                                                Text(
                                                  "\n100KP",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          ),
                                          CupertinoButton(
                                            onPressed: () {
                                              state.onPurchase(mainState, vM,
                                                  goods, context, 2.0);
                                            },
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 30),
                                            color: Colors.grey[700],
                                            child: Column(
                                              children: [
                                                Text("- RM 2"),
                                                Text(
                                                  "\n200KP",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          ),
                                          CupertinoButton(
                                            onPressed: () {
                                              state.onPurchase(mainState, vM,
                                                  goods, context, 5.0);
                                            },
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 30),
                                            color: Colors.grey[800],
                                            child: Column(
                                              children: [
                                                Text("- RM 5"),
                                                Text(
                                                  "\n500KP",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 30),
                                        child: CupertinoButton(
                                          onPressed: () {
                                            state.onPurchase(mainState, vM,
                                                goods, context, 0.0);
                                          },
                                          child: Text(
                                            "Pay Without Voucher",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                          title: Text([
                            'Croco-Wallet',
                            'Croco-Wallet + Points',
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

// class SliderWidget extends StatefulWidget {
//   @override
//   _SliderWidgetState createState() => _SliderWidgetState();
// }

// class _SliderWidgetState extends State<SliderWidget> {
//   bool voucher1 = false, voucher2 = false, voucher3 = false;

//   @override
//   Widget build(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) => Container(
//         height: MediaQuery.of(context).size.height * 0.4,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               title: Text("Select Voucher"),
//             ),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 CupertinoButton(
//                   pressedOpacity: 0.4,
//                   onPressed: () {
//                     setState(() {
//                       voucher1 = true;
//                     });
//                   },
//                   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
//                   color: voucher1 ? Colors.blue : Colors.grey[600],
//                   child: Column(
//                     children: [
//                       Text("- RM 1"),
//                       Text(
//                         "\n100KP",
//                         style: TextStyle(
//                             color: Colors.white, fontWeight: FontWeight.bold),
//                       )
//                     ],
//                   ),
//                 ),
//                 CupertinoButton(
//                   pressedOpacity: 0.4,
//                   onPressed: () {
//                     setState(() {
//                       voucher2 = true;
//                     });
//                   },
//                   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
//                   color: voucher2 ? Colors.blue : Colors.grey[700],
//                   child: Column(
//                     children: [
//                       Text("- RM 2"),
//                       Text(
//                         "\n200KP",
//                         style: TextStyle(
//                             color: Colors.white, fontWeight: FontWeight.bold),
//                       )
//                     ],
//                   ),
//                 ),
//                 CupertinoButton(
//                   pressedOpacity: 0.4,
//                   onPressed: () {
//                     setState(() {
//                       voucher3 = true;
//                     });
//                   },
//                   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
//                   color: voucher3 ? Colors.blue : Colors.grey[800],
//                   child: Column(
//                     children: [
//                       Text("- RM 5"),
//                       Text(
//                         "\n500KP",
//                         style: TextStyle(
//                             color: Colors.white, fontWeight: FontWeight.bold),
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class CheckOutPageState with ChangeNotifier {
  BuildContext buildContext;

  CheckOutPageState(this.buildContext);

  onPurchase(MainAppState mainState, VendingMachine vM, Goods goods,
      BuildContext context, double discount) {
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
          .updateBalance(-goods.price + discount)
          .updatePoint(-discount)
          .updatePurchasingHistory((List<dynamic> ls) {
        ls.add(pH);
        return ls;
      }),
    );

    mainState.updateVendingMachineList(
      (List<VendingMachine> list) => list.map(
        (VendingMachine vendingMachine) {
          return vendingMachine.vendId == vM.vendId
              ? vendingMachine
                  .updateStockNum(goods, -1)
                  .updatePurchasingHistory((List ls) {
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
        builder: (context) => RoutingPage(
          mainState.thisAppUser.location,
          vM.coor,
        ),
      ),
    );
  }
}
