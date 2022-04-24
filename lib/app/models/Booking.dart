import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
  String? custId;
  String? techId;
  double? rate;
  String? bookStatus; //pending, booked, on going, done, canceled
  String? paidStatus; //paid, not paid
  DateTime? created_at;
  DateTime? bookDate;

  // Booking({this.custId, this.rate, this.created_at});
  Booking();

  Booking.fromJson(Map<String, dynamic> json) {
    custId = json["custId"];
    techId = json["techId"];
    rate = json["rate"];
    bookStatus = json["bookStatus"];
    paidStatus = json["paidStatus"];
    created_at = json["created_at"];
    bookDate = json["bookDate"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data["custId"] = this.custId;
    data["techId"] = this.techId;
    data["rate"] = this.rate;
    data["bookStatus"] = this.bookStatus;
    data["paidStatus"] = this.paidStatus;
    data["created_at"] = this.created_at;
    data["bookDate"] = this.bookDate;

    return data;
  }

  Booking.fromSnapshot(snapshot)
      : custId = snapshot.data()["custId"],
        techId = snapshot.data()["techId"],
        rate = snapshot.data()["rate"].toDouble(),
        bookStatus = snapshot.data()["bookStatus"],
        paidStatus = snapshot.data()["paidStatus"],
        created_at = snapshot.data()["created_at"].toDate(),
        bookDate = snapshot.data()["bookDate"].toDate();
}
