import 'package:cloud_firestore/cloud_firestore.dart';

class Customer {
  String? custId;
  String? custEmail;
  String? custFName;
  String? custLName;
  String? custPhone;
  String? custPicture;

  Customer({this.custEmail, this.custFName, this.custLName, this.custPhone});

  // Customer.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> snap) {
  //   custId = (snap.data() as dynamic)["custId"];
  //   custEmail = (snap.data() as dynamic)["custEmail"];
  //   custFName = (snap.data() as dynamic)["custFName"];
  //   custLName = (snap.data() as dynamic)["custLName"];
  //   custPhone = (snap.data() as dynamic)["custPhone"];
  // }

  Customer.fromSnapshot(snapshot)
      : custId = snapshot.data()["custId"],
        custEmail = snapshot.data()["custEmail"],
        custFName = snapshot.data()["custFName"],
        custLName = snapshot.data()["custLName"],
        custPhone = snapshot.data()["custPhone"],
        custPicture = snapshot.data()["custPicture"];

  Customer.fromJson(Map<String, dynamic> json) {
    custId = json["custId"];
    custEmail = json["custEmail"];
    custFName = json["custFName"];
    custLName = json["custLName"];
    custPhone = json["custPhone"];
    custPicture = json["custPicture"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data["custId"] = this.custId;
    data["custEmail"] = this.custEmail;
    data["custFName"] = this.custFName;
    data["custLName"] = this.custLName;
    data["custPhone"] = this.custPhone;
    data["custPicture"] = this.custPicture;

    return data;
  }
}
