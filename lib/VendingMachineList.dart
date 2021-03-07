import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CheckoutPage.dart';
import 'Classes/Goods.dart';
import 'Classes/VendingMachine.dart';
import 'VendingMachinePage.dart';

class VendingMachineList extends StatelessWidget {
  List<VendingMachine> availableVM = [];
  Goods good;
  VendingMachineList(List<VendingMachine> this.availableVM, Goods this.good);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Vending Machines "),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                child: availableVM.toList().length == 0
                    ? Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Oops item not available'),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: availableVM.toList().length,
                        itemBuilder: (context, index) {
                          VendingMachine thisVM = availableVM.toList()[index];
                          return ListTile(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CheckoutPage(availableVM[index], this.good),
                              ),
                            ),
                            title: Text(thisVM.name),
                            subtitle: Text(thisVM.distance.toString()),
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
