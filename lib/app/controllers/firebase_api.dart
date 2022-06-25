import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hifixit/app/controllers/utils.dart';
import 'package:hifixit/app/models/Customer.dart';
import 'package:hifixit/app/models/Message.dart';
import 'package:hifixit/app/models/Technician.dart';
import 'package:hifixit/app/services/global.dart';

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

  static Future uploadCustMessage(
      //message created by cust
      String userId,
      String message,
      String techId) async {
    final refMessages =
        FirebaseFirestore.instance.collection('Chat/$techId$userId/Messages');
    final refCustomers = FirebaseFirestore.instance.collection('Customer');
    var custSnapshot = await refCustomers.doc(userId).get();
    Map<String, dynamic>? custData = custSnapshot.data();

    final newMessage = Message(
      userId: userId,
      userPicture: custData?['custPicture'],
      email: custData!['custEmail'],
      message: message,
      userType: 'customer',
      messageTo: techId,
      createdAt: DateTime.now(),
    );
    await refMessages.add(newMessage.toJson());

    await refCustomers
        .doc(userId)
        .update({UserField.lastMessageTime: DateTime.now()});
    // await refCustomers
    //     .doc(userId)
    //     .collection('MessagesTime')
    //     .doc(techId + userId)
    //     .update({UserField.lastMessageTime: DateTime.now()});
  }

  static Future uploadTechMessage(
      //message created by tech
      String userId,
      String message,
      String custId) async {
    final refMessages =
        FirebaseFirestore.instance.collection('Chat/$userId$custId/Messages');
    final refTechnicians = FirebaseFirestore.instance.collection('Technician');
    var techSnapshot = await refTechnicians.doc(userId).get();
    Map<String, dynamic>? techData = techSnapshot.data();

    final newMessage = Message(
      userId: userId,
      userPicture: techData?['techPicture'],
      email: techData!['techEmail'],
      message: message,
      userType: 'technician',
      messageTo: custId,
      createdAt: DateTime.now(),
    );
    await refMessages.add(newMessage.toJson());

    await refTechnicians
        .doc(userId)
        .update({UserField.lastMessageTime: DateTime.now()});
    // await refTechnicians
    //     .doc(userId)
    //     .collection('MessagesTime')
    //     .doc(userId + custId)
    //     .update({UserField.lastMessageTime: DateTime.now()});
  }

  static Stream<List<Message>> getCustMessages(String custId, String userId) =>
      FirebaseFirestore.instance
          .collection('Chat')
          .doc(userId + custId)
          .collection('Messages')
          // .where('messageTo', whereIn: [custId, userId])
          .orderBy('createdAt', descending: true)
          .snapshots()
          .transform(Utils.transformer(Message.fromJson));

  static Stream<List<Message>> getTechMessages(String techId, String userId) =>
      FirebaseFirestore.instance
          .collection('Chat')
          .doc(techId + userId)
          .collection('Messages')
          // .where('messageTo', isEqualTo: techId)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .transform(Utils.transformer(Message.fromJson));
}
