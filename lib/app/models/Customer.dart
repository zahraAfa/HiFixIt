import 'package:cloud_firestore/cloud_firestore.dart';

class UserField {
  static final String lastMessageTime = 'lastMessageTime';
}

class Customer {
  String? custId;
  String? custEmail;
  String? custFName;
  String? custLName;
  String? custPhone;
  String? custPicture;
  String? currLocation;
  double? latitude;
  double? longitude;

  Customer(
      {this.custEmail,
      this.custFName,
      this.custLName,
      this.custPicture,
      this.currLocation,
      this.latitude,
      this.longitude,
      this.custPhone,
      this.custId});

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
        currLocation = snapshot.data()["currLocation"],
        latitude = snapshot.data()["latitude"],
        longitude = snapshot.data()["longitude"],
        custPicture = snapshot.data()["custPicture"];

  // Customer.fromJson(Map<String, dynamic> json) {
  //   custId = json["custId"];
  //   custEmail = json["custEmail"];
  //   custFName = json["custFName"];
  //   custLName = json["custLName"];
  //   custPhone = json["custPhone"];
  //   custPicture = json["custPicture"];
  //   currLocation = json["currLocation"];
  //   latitude = json["latitude"];
  //   longitude = json["longitude"];
  // }
  static Customer fromJson(Map<String, dynamic> json) => Customer(
        custId: json["custId"],
        custEmail: json["custEmail"],
        custFName: json["custFName"],
        custLName: json["custLName"],
        custPhone: json["custPhone"],
        custPicture: json["custPicture"],
        currLocation: json["currLocation"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data["custId"] = this.custId;
    data["custEmail"] = this.custEmail;
    data["custFName"] = this.custFName;
    data["custLName"] = this.custLName;
    data["custPhone"] = this.custPhone;
    data["custPicture"] = this.custPicture;
    data["longitude"] = this.longitude;
    data["latitude"] = this.latitude;
    data["currLocation"] = this.currLocation;

    return data;
  }
}
