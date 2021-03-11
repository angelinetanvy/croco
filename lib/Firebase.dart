import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseClass {
  CollectionReference vendingmachinereference =
      FirebaseFirestore.instance.collection('vending');

  CollectionReference userReference =
      FirebaseFirestore.instance.collection('users');

  StreamSubscription userMachineListStream() {
    return userReference.snapshots().listen((event) {
      event.docs.forEach((c) => print(c));
    });
  }

  StreamSubscription vendingMachineListStream() {
    return vendingmachinereference
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((c) => print(c));
    });
  }
}
