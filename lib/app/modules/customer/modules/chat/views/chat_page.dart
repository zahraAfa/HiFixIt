import 'package:flutter/material.dart';
import 'package:hifixit/app/models/Customer.dart';
import 'package:hifixit/app/models/Technician.dart';
import 'package:hifixit/app/modules/customer/modules/chat/views/messages_widget.dart';
import 'package:hifixit/app/modules/customer/modules/chat/views/new_message_widget.dart';
import 'package:hifixit/app/modules/customer/modules/chat/views/profile_header_widget.dart';

class ChatPage extends StatefulWidget {
  // final Customer customer;
  final Technician technician;

  const ChatPage({
    required this.technician,
    Key? key,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: const Color(0xFF7B4067),
        body: SafeArea(
          child: Column(
            children: [
              ProfileHeaderWidget(
                  name: widget.technician.techFName.toString(),
                  techId: widget.technician.techId),
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
                  child: MessagesWidget(techId: widget.technician.techId),
                ),
              ),
              NewMessageWidget(techId: widget.technician.techId)
            ],
          ),
        ),
      );
}
