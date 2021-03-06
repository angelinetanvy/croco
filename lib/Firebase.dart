import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:croco/Classes/VendingMachine.dart';

class FirebaseClass {
  CollectionReference vendingmachinereference =
      FirebaseFirestore.instance.collection('vending');

  // Stream<List<VendingMachine>> vendingMachineListStream() {
  //   vendingmachinereference.snapshots().listen((QuerySnapshot querySnapshot) {
  //     querySnapshot.documents.forEach((document) => print(document));
  //   });
  // }
}
