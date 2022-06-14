import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hifixit/app/modules/technician/modules/history/views/history_tab.dart';
import 'package:hifixit/app/modules/technician/modules/schedule/views/schedule_tab.dart';

techBookingUpdate({
  context,
  bookStatus,
  bookId,
}) async {
  Map<String, dynamic> updateTechBook = {
    "bookStatus": bookStatus,
  };

  FirebaseFirestore.instance
      .collection("Booking")
      .doc(bookId)
      .update(updateTechBook);

  if (bookStatus == "Booked") {
    Fluttertoast.showToast(msg: "Booked");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (c) => const ScheduleTabPage()),
        (Route<dynamic> route) => route.isFirst);
  } else if (bookStatus == "Rejected") {
    Fluttertoast.showToast(msg: "Rejected");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (c) => const HistoryTabPage()),
        (Route<dynamic> route) => route.isFirst);
  } else if (bookStatus == "Ongoing") {
    Fluttertoast.showToast(msg: "Ongoing");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (c) => const HistoryTabPage()),
        (Route<dynamic> route) => route.isFirst);
  } else if (bookStatus == "Completed") {
    Fluttertoast.showToast(msg: "Completed");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (c) => const HistoryTabPage()),
        (Route<dynamic> route) => route.isFirst);
  }
}
