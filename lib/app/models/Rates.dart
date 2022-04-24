import 'package:cloud_firestore/cloud_firestore.dart';

class Rates {
  String? custId;
  double? rate;
  DateTime? created_at;

  // Rates({this.custId, this.rate, this.created_at});
  Rates();

  Rates.fromJson(Map<String, dynamic> json) {
    custId = json["custId"];
    rate = json["rate"];
    created_at = json["created_at"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data["custId"] = this.custId;
    data["rate"] = this.rate;
    data["created_at"] = this.created_at;

    return data;
  }

  Rates.fromSnapshot(snapshot)
      : custId = snapshot.data()["custId"],
        rate = snapshot.data()["rate"].toDouble(),
        created_at = snapshot.data()["created_at"].toDate();
}
