import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

techReviewUpdate({
  context,
  paidStatus,
  bookId,
}) async {
  Map<String, dynamic> updateTechBook = {
    "paidStatus": paidStatus,
  };

  FirebaseFirestore.instance
      .collection("Booking")
      .doc(bookId)
      .update(updateTechBook);
  Navigator.pop(context);
}
