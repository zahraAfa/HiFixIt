import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:hifixit/app/models/Customer.dart';
import 'package:hifixit/app/services/global.dart';

class AssistantMethod {
  static void readCurrentOnlineCustInfo() async {
    currentFirebaseUser = fAuth.currentUser;
    DatabaseReference custRef = FirebaseDatabase.instance
        .ref()
        .child('Customer')
        .child(currentFirebaseUser!.uid);

    custRef.once().then((snap) {
      if (snap.snapshot.value != null) {
        custModelCurrentInfo = Customer.fromSnapshot(snap.snapshot);
        print("name : " + custModelCurrentInfo!.custEmail.toString());
      }
    });
  }
}
