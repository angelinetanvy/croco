import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseClass {
  CollectionReference vendingmachinereference =
      FirebaseFirestore.instance.collection('vending');

  StreamSubscription vendingMachineListStream() {
    return vendingmachinereference
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((c) => print(c));
    });
  }
}
