import 'package:firebase_database/firebase_database.dart';

class Customer {
  String? custEmail;
  String? custFName;
  String? custLName;
  String? custPhone;
  String? custId;

  Customer({this.custEmail, this.custFName, this.custLName, this.custPhone});

  Customer.fromSnapshot(DataSnapshot snap) {
    custId = (snap.value as dynamic)["custId"];
    custEmail = (snap.value as dynamic)["custEmail"];
    custFName = (snap.value as dynamic)["custFName"];
    custLName = (snap.value as dynamic)["custLName"];
    custPhone = (snap.value as dynamic)["custPhone"];
  }
}
