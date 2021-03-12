import 'package:croco/Firebase.dart';
import 'package:croco/MainAppState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MainAppState mainState = context.watch<MainAppState>();
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
            ChangeNotifierProvider(
              create: (_) => LoginPageState(),
              builder: (context, snapshot) {
                LoginPageState state = context.watch<LoginPageState>();
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CupertinoTextField(
                        controller: state.email,
                        padding: EdgeInsets.all(10),
                        placeholder: "Email",
                      ),
                      SizedBox(height: 10),
                      CupertinoTextField(
                        obscureText: true,
                        padding: EdgeInsets.all(10),
                        controller: state.password,
                        placeholder: "Password",
                      ),
                      SizedBox(height: 10),
                      CupertinoButton(
                        onPressed: () {
                          FirebaseClass().loginWithEmailAndPassword(
                            state.email.text,
                            state.password.text,
                            (a) => mainState.updateAppUser(a),
                            context,
                          );
                        },
                        color: Colors.black,
                        child: Text("Enter"),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LoginPageState extends ChangeNotifier {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  LoginPageState();
}
