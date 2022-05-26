import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hifixit/app/modules/customer/modules/home/views/home_tab.dart';
import 'package:hifixit/app/services/global.dart';
import 'package:hifixit/app/widgets/progress_dialog.dart';

createBookNow({
  context,
  techId,
  bookDate,
  bookStatus,
  paidStatus,
}) async {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext c) {
        return ProgressDialog(
          message: "Processing, Please wait...",
        );
      });
  final User? firebaseUser = currentFirebaseUser;
  if (firebaseUser != null) {
    Map<String, dynamic> bookMap = {
      "custId": firebaseUser.uid,
      "techId": techId,
      "bookDate": bookDate.trim(),
      "bookStatus": paidStatus.trim(),
      "paidStatus": 'Not Paid',
      "rate": 0,
    };

    FirebaseFirestore.instance.collection("Booking").doc().set(bookMap);
  } else {
    Fluttertoast.showToast(msg: "Booking has not been created.");
  }

  Fluttertoast.showToast(msg: "New booking has been created.");
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (c) => const HomeTabPage(),
    ),
  );
}
