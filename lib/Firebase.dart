import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:croco/Classes/AppUsers.dart';
import 'package:croco/Classes/VendingMachine.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseClass {
  CollectionReference vendingmachinereference =
      FirebaseFirestore.instance.collection('vending');
  CollectionReference userReference =
      FirebaseFirestore.instance.collection('users');

  loginUserWithFirebase(Function(AppUsers) onFinish) async {
    print("Running");
    final _googleSignIn = new GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential).then(
      (value) {
        if (value.additionalUserInfo.isNewUser)
          userReference.doc(value.user.uid).set(AppUsers(
                  value.user.uid,
                  value.user.displayName,
                  value.user.email,
                  0,
                  value.user.displayName,
                  "male",
                  "2000 - 10 - 30",
                  [],
                  LatLng(3.064411, 101.600682),
                  0)
              .toMap());
        userReference.doc(value.user.uid).snapshots().listen(
              (event) => onFinish(
                AppUsers.fromMap(
                  event.data(),
                ),
              ),
            );
      },
    );
  }

  void updatesUserInFirebase(String userId, AppUsers updatedUser) =>
      userReference.doc(userId).update(updatedUser.toMap());

  void updateVendingMachine(String vendingMachineId, VendingMachine newValue) {
    vendingmachinereference.doc(vendingMachineId).update(newValue.toMap());
  }

  StreamSubscription vendingMachineListStream(
    void Function(VendingMachine) onMachineStream,
  ) {
    return vendingmachinereference
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach(
        (c) => onMachineStream(
          VendingMachine.fromMap(
            c.data(),
          ),
        ),
      );
    });
  }
}
