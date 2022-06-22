import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hifixit/app/controllers/utils.dart';
import 'package:hifixit/app/models/Customer.dart';

// import 'package:js/js_util.dart';

class FirebaseApi {
  static Stream<List<Customer>> getCustomers() => FirebaseFirestore.instance
      .collection('Customer')
      .orderBy(UserField.lastMessageTime, descending: true)
      .snapshots()
      .transform(Utils.transformer(Customer.fromJson));
}
