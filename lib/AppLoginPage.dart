import 'package:croco/Classes/AppUsers.dart';
import 'package:croco/Firebase.dart';
import 'package:croco/MainAppState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MainAppState state = context.watch<MainAppState>();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 20),
                  child: Container(
                    width: 150,
                    height: 150,
                    child: Image(
                      image: AssetImage(
                        "assets/images/vendingMachineImage.png",
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "H E L L O",
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                    Text(
                      "T H E R E",
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            CupertinoButton(
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.login),
                  SizedBox(width: 20),
                  Text("Login with Google"),
                ],
              ),
              onPressed: () {
                FirebaseClass().loginUserWithFirebase(
                  (AppUsers appUser) => state.updateAppUser(appUser),
                  context,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
