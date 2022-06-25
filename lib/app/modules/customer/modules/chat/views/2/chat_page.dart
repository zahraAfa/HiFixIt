import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hifixit/app/models/Customer.dart';
import 'package:hifixit/app/models/Technician.dart';
import 'package:hifixit/app/modules/customer/modules/chat/views/messages_widget.dart';
import 'package:hifixit/app/modules/customer/modules/chat/views/new_message_widget.dart';
import 'package:hifixit/app/modules/customer/modules/chat/views/profile_header_widget.dart';

class ChatPage2 extends StatefulWidget {
  // final Customer customer;
  final String techId;

  const ChatPage2({
    required this.techId,
    Key? key,
  }) : super(key: key);

  @override
  _ChatPage2State createState() => _ChatPage2State();
}

class _ChatPage2State extends State<ChatPage2> {
  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: const Color(0xFF7B4067),
        body: SafeArea(
          child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection("Technician")
                  .doc(widget.techId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator.adaptive();
                }
                return Column(
                  children: [
                    ProfileHeaderWidget(
                        name: snapshot.data!['techFName'].toString(),
                        techId: widget.techId),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                        ),
                        child: MessagesWidget(techId: widget.techId),
                      ),
                    ),
                    NewMessageWidget(techId: widget.techId)
                  ],
                );
              }),
        ),
      );
}
