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
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 20),
                  child: Container(
                    width: 150,
                    height: 150,
                    child: Image(
                      image: NetworkImage(
                        "https://raw.githubusercontent.com/angelinetanvy/Yulehensem/main/croco/assets/images/logo.png?token=AOYPJSHNOSN36ZXTBH33243AJIBCO",
                      ),
                    ),
                  ),
                ),
                Text(
                  "WELCOME",
                  style: TextStyle(
                    fontSize: 20,
                  ),
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
