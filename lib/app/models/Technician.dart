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

  Technician(
      {this.techEmail,
      this.techFName,
      this.techLName,
      this.techPhone,
      this.techPicture,
      this.techCategory,
      this.rating});

  Technician.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> snap) {
    techId = (snap.data() as dynamic)["techId"];
    techEmail = (snap.data() as dynamic)["techEmail"];
    techFName = (snap.data() as dynamic)["techFName"];
    techLName = (snap.data() as dynamic)["techLName"];
    techPhone = (snap.data() as dynamic)["techPhone"];
    rating = (snap.data() as dynamic)["rating"];
    techCategory = (snap.data() as dynamic)["techCategory"];
    techPicture = (snap.data() as dynamic)["techPicture"];
  }
}