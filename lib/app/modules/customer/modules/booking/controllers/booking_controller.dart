import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hifixit/app/modules/customer/modules/pending/views/pending_booking_page.dart';
import 'package:hifixit/app/services/global.dart';
import 'package:hifixit/app/widgets/progress_dialog.dart';

DateTime? pickedBookDate;
TimeOfDay? pickedBookTime;
DateTime? getFullDateTime;

setBookingDate(date) {
  pickedBookDate = date;
  if (pickedBookTime == null) {
    return;
  } else {
    getFullDateTime = DateTime(pickedBookDate!.year, pickedBookDate!.month,
        pickedBookDate!.day, pickedBookTime!.hour, pickedBookTime!.minute);
    // print(getFullDateTime);
  }
}

setBookingTime(time) {
  pickedBookTime = time;
  if (pickedBookDate == null) {
    return;
  } else {
    getFullDateTime = DateTime(pickedBookDate!.year, pickedBookDate!.month,
        pickedBookDate!.day, pickedBookTime!.hour, pickedBookTime!.minute);
    // print(getFullDateTime);
  }
}

createBookNow({
  context,
  techId,
  bookStatus,
  paidStatus,
  location,
  locationDetail,
  reparationDetail,
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
      "bookDate": getFullDateTime,
      "bookStatus": 'Pending',
      "paidStatus": 'Not Paid',
      "rate": 0,
      "location": location.trim(),
      "locationDetail": locationDetail.trim(),
      "reparationDetail": reparationDetail.trim(),
      "created_at": DateTime.now(),
    };

    FirebaseFirestore.instance.collection("Booking").doc().set(bookMap);
  } else {
    Fluttertoast.showToast(msg: "Booking has not been created.");
  }

  Fluttertoast.showToast(msg: "New booking has been created.");
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (c) => const PendingBookingPage()),
      (Route<dynamic> route) => route.isFirst);
}
