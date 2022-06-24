import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hifixit/app/controllers/utils.dart';
import 'package:hifixit/app/models/Customer.dart';
import 'package:hifixit/app/models/Message.dart';
import 'package:hifixit/app/models/Technician.dart';
import 'package:hifixit/app/services/global.dart';

// import 'package:js/js_util.dart';

class FirebaseApi {
  static Stream<List<Customer>> getCustomers() => FirebaseFirestore.instance
      .collection('Customer')
      .snapshots()
      .transform(Utils.transformer(Customer.fromJson));

  static Stream<List<Customer>> getCustomersChatList() =>
      FirebaseFirestore.instance
          .collection('Customer')
          .orderBy(UserField.lastMessageTime, descending: true)
          .snapshots()
          .transform(Utils.transformer(Customer.fromJson));

  static Stream<List<Technician>> getTechnicians() => FirebaseFirestore.instance
      .collection('Technician')
      .snapshots()
      .transform(Utils.transformer(Technician.fromJson));

  static Stream<List<Technician>> getTechniciansChatList() =>
      FirebaseFirestore.instance
          .collection('Technician')
          .orderBy(UserField.lastMessageTime, descending: true)
          .snapshots()
          .transform(Utils.transformer(Technician.fromJson));

  static Future uploadCustMessage(String userId, String message) async {
    final refMessages =
        FirebaseFirestore.instance.collection('Chat/Customer/$userId/Messages');
    final refCustomers = FirebaseFirestore.instance.collection('Customer');
    var custSnapshot = await refCustomers.doc(userId).get();
    Map<String, dynamic>? custData = custSnapshot.data();

    // var customer = Customer.getCurrCustomer();

    final newMessage = Message(
      userId: currentFirebaseUser!.uid,
      userPicture: custData?['custPicture'] ?? null,
      email: custData!['custEmail'],
      message: message,
      userType: 'customer',
      createdAt: DateTime.now(),
    );
    await refMessages.add(newMessage.toJson());

    // final refUsers = FirebaseFirestore.instance.collection('users');
    await refCustomers
        .doc(userId)
        .update({UserField.lastMessageTime: DateTime.now()});
  }

  static Future uploadTechMessage(String userId, String message) async {
    final refMessages = FirebaseFirestore.instance
        .collection('Chat/Technician/$userId/Messages');
    final refTechnicians = FirebaseFirestore.instance.collection('Technician');
    var techSnapshot = await refTechnicians.doc(userId).get();
    Map<String, dynamic>? techData = techSnapshot.data();

    // var techomer = techomer.getCurrtechomer();

    final newMessage = Message(
      userId: currentFirebaseUser!.uid,
      userPicture: techData?['techPicture'] ?? null,
      email: techData!['techEmail'],
      message: message,
      userType: 'technician',
      createdAt: DateTime.now(),
    );
    await refMessages.add(newMessage.toJson());

    // final refUsers = FirebaseFirestore.instance.collection('users');
    await refTechnicians
        .doc(userId)
        .update({UserField.lastMessageTime: DateTime.now()});
  }

  static Stream<List<Message>> getCustMessages(String userId) =>
      FirebaseFirestore.instance
          .collection('Chat/Customer/$userId/Messages')
          .orderBy(MessageField.createdAt, descending: true)
          .snapshots()
          .transform(Utils.transformer(Message.fromJson));

  static Stream<List<Message>> getTechMessages(String userId) =>
      FirebaseFirestore.instance
          .collection('Chat/Customer/$userId/Messages')
          .orderBy(MessageField.createdAt, descending: true)
          .snapshots()
          .transform(Utils.transformer(Message.fromJson));
}
