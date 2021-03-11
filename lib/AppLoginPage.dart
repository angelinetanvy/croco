import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoButton(
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.login),
                  SizedBox(width: 20),
                  Text("Login with google"),
                ],
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
