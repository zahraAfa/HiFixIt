import 'package:flutter/material.dart';
import 'package:hifixit/app/controllers/firebase_api.dart';
import 'package:hifixit/app/models/Customer.dart';
import 'package:hifixit/app/models/Technician.dart';
import 'package:hifixit/app/modules/customer/modules/chat/views/chat_body_widget.dart';

class ChatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Chats'),
          elevation: 0,
        ),
        backgroundColor: Color(0xFF7B4067),
        body: SafeArea(
          child: StreamBuilder<List<Technician>>(
            stream: FirebaseApi.getTechniciansChatList(),
            builder: (context, snapshotTech) {
              // print(snapshotTech.data);
              switch (snapshotTech.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  if (snapshotTech.hasError) {
                    print(snapshotTech.error);
                    return buildText('Something Went Wrong Try later');
                  } else {
                    final technician = snapshotTech.data;

                    if (technician!.isEmpty) {
                      return buildText('No Users Found');
                    } else {
                      return Column(
                        children: [ChatBodyWidget(technicians: technician)],
                      );
                    }
                  }
              }
            },
          ),
        ),
      );

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      );
}
