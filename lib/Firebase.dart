import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:croco/Classes/AppUsers.dart';

class FirebaseClass {
  CollectionReference vendingmachinereference =
      FirebaseFirestore.instance.collection('vending');

  CollectionReference userReference =
      FirebaseFirestore.instance.collection('users');

  StreamSubscription userMachineListStream(
      String userId, void Function(AppUsers) listenFunction) {
    return userReference
        .doc(userId)
        .snapshots()
        .listen((event) => listenFunction(AppUsers.fromMap(event.data())));
  }

  void updatesUserInFirebase(String userId, AppUsers updatedUser) =>
      userReference.doc(userId).update(updatedUser.toMap());

  StreamSubscription vendingMachineListStream() {
    return vendingmachinereference
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((c) => print(c));
    });
  }
}
