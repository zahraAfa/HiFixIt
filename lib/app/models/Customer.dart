import 'package:cloud_firestore/cloud_firestore.dart';

class Customer {
  String? custEmail;
  String? custFName;
  String? custLName;
  String? custPhone;
  String? custId;

  Customer({this.custEmail, this.custFName, this.custLName, this.custPhone});

  Customer.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> snap) {
    custId = (snap.data() as dynamic)["custId"];
    custEmail = (snap.data() as dynamic)["custEmail"];
    custFName = (snap.data() as dynamic)["custFName"];
    custLName = (snap.data() as dynamic)["custLName"];
    custPhone = (snap.data() as dynamic)["custPhone"];
  }
}
