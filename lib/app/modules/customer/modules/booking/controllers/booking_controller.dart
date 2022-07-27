import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hifixit/app/modules/customer/modules/history/views/history_tab.dart';
import 'package:hifixit/app/modules/customer/modules/pending/views/pending_booking_page.dart';
import 'package:hifixit/app/modules/customer/modules/profile/views/profile_tab.dart';
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

custBookingUpdate({
  context,
  bookStatus,
  bookId,
}) async {
  Map<String, dynamic> custBookUpdateMap = {
    "bookStatus": bookStatus,
  };

  FirebaseFirestore.instance
      .collection("Booking")
      .doc(bookId)
      .update(custBookUpdateMap);

  Fluttertoast.showToast(msg: "Updated");
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (c) => const HistoryTabPage()),
      (Route<dynamic> route) => route.isFirst);
}

custReviewUpdate({
  context,
  bookId,
  rate,
  techId,
  custId,
}) async {
  Map<String, dynamic> custReviewUp = {
    "rate": rate,
  };
  Map<String, dynamic> custReviewTech = {
    "created_at": DateTime.now(),
    "custId": custId,
    "rate": rate,
  };

  FirebaseFirestore.instance
      .collection("Booking")
      .doc(bookId)
      .update(custReviewUp);

  FirebaseFirestore.instance
      .collection("Technician")
      .doc(techId)
      .collection('Rates')
      .doc()
      .set(custReviewTech);

  var collection = FirebaseFirestore.instance.collection('Technician');
  var docSnapshot = await collection.doc(techId).get();
  if (docSnapshot.exists) {
    print('exists');
    Map<String, dynamic>? data = docSnapshot.data();

    // DocumentSnapshot variable = await FirebaseFirestore.instance.collection('Technician').doc('tech').get();
    var rateNow = data?['rating'];
    double techRate = (rateNow + rate) / 2;

    Map<String, dynamic> techRateCalc = {
      "rating": techRate,
    };

    print(techRate);

    FirebaseFirestore.instance
        .collection("Technician")
        .doc(techId)
        .update(techRateCalc);
  }

  Fluttertoast.showToast(msg: "Rated");
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (c) => ProfileTabPage(techId: techId)),
      (Route<dynamic> route) => route.isFirst);
}
