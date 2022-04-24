import 'package:cloud_firestore/cloud_firestore.dart';

class Technician {
  String? techId;
  String? techEmail;
  String? techFName;
  String? techLName;
  String? techPhone;
  double? rating;
  String? techCategory;
  String? techPicture;
  String? techStatus;

  Technician(
      {this.techEmail,
      this.techFName,
      this.techLName,
      this.techPhone,
      this.techPicture,
      this.techCategory,
      this.techStatus,
      this.rating});

  Technician.fromSnapshot(snapshot)
      : techId = snapshot.data()["techId"],
        techEmail = snapshot.data()["techEmail"],
        techFName = snapshot.data()["techFName"],
        techLName = snapshot.data()["techLName"],
        techPhone = snapshot.data()["techPhone"],
        rating = snapshot.data()["rating"],
        techCategory = snapshot.data()["techCategory"],
        techStatus = snapshot.data()["techStatus"],
        techPicture = snapshot.data()["techPicture"];

  Technician.fromJson(Map<String, dynamic> json) {
    techId = json["techId"];
    techEmail = json["techEmail"];
    techFName = json["techFName"];
    techLName = json["techLName"];
    techPhone = json["techPhone"];
    techPicture = json["techPicture"];
    techCategory = json["techCategory"];
    rating = json["rating"];
    techStatus = json["techStatus"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data["techId"] = this.techId;
    data["techEmail"] = this.techEmail;
    data["techFName"] = this.techFName;
    data["techLName"] = this.techLName;
    data["techPhone"] = this.techPhone;
    data["techPicture"] = this.techPicture;
    data["techCategory"] = this.techCategory;
    data["rating"] = this.rating;
    data["techStatus"] = this.techStatus;

    return data;
  }
}
