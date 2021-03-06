import 'package:croco/CheckoutPage.dart';
import 'package:croco/Classes/Goods.dart';
import 'package:flutter/material.dart';
import 'Classes/VendingMachine.dart';

class VendingMachinePage extends StatelessWidget {
  final VendingMachine vM;

  VendingMachinePage(this.vM);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ListTile(
              title: Text(vM.name),
              subtitle: Text(vM.distance.toString() + " m"),
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                  itemCount: vM.stocks
                      .where((Goods goods) => goods.stock > 0)
                      .toList()
                      .length,
                  itemBuilder: (context, index) {
                    Goods thisGoods = vM.stocks
                        .where((Goods goods) => goods.stock > 0)
                        .toList()[index];
                    return ListTile(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckoutPage(vM, thisGoods),
                        ),
                      ),
                      leading: Image.asset(thisGoods.image),
                      title: Text(thisGoods.name),
                      subtitle: Text(thisGoods.stock.toString()),
                      trailing: Text("RM " + thisGoods.price.toString()),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
