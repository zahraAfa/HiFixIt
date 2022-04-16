// import 'dart:ffi';

// import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hifixit/app/models/Customer.dart';
import 'package:hifixit/app/services/global.dart';

class AssistantMethod {
  static void readCurrentOnlineCustInfo() async {
    currentFirebaseUser = fAuth.currentUser;
    // DatabaseReference custRef = FirebaseDatabase.instance
    //     .ref()
    //     .child('Customer')
    //     .child(currentFirebaseUser!.uid);

    // custRef.once().then((snap) {
    //   if (snap.snapshot.value != null) {
    //     custModelCurrentInfo = Customer.fromDocumentSnapshot(snap.snapshot);
    //     print("name : " + custModelCurrentInfo!.custEmail.toString());
    //   }
    // });

    // CollectionReference UserCol

    // Stream<DocumentSnapshot<Map<String, dynamic>>> _custInfo = FirebaseFirestore.instance
    //     .collection("Customer")
    //     .doc(currentFirebaseUser!.uid)
    //     .snapshots().;
    // custModelCurrentInfo = Customer.fromDocumentSnapshot(_custInfo);
    Stream<List<Customer>> readCust() => FirebaseFirestore.instance
        .collection("Customer")
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Customer.fromJson(doc.data())).toList());
  }

  static void readCurrentOnlineTechInfo() async {
    currentFirebaseUser = fAuth.currentUser;
    // DatabaseReference custRef = FirebaseDatabase.instance
    //     .ref()
    //     .child('Customer')
    //     .child(currentFirebaseUser!.uid);

    // custRef.once().then((snap) {
    //   if (snap.snapshot.value != null) {
    //     custModelCurrentInfo = Customer.fromDocumentSnapshot(snap.snapshot);
    //     print("name : " + custModelCurrentInfo!.custEmail.toString());
    //   }
    // });

    // CollectionReference UserCol

    // Stream<DocumentSnapshot<Map<String, dynamic>>> _custInfo = FirebaseFirestore.instance
    //     .collection("Technician")
    //     .doc(currentFirebaseUser!.uid)
    //     .snapshots();
    //     custModelCurrentInfo = Customer.fromDocumentSnapshot(_custInfo);
  }
}
