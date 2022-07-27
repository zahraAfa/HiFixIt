import 'package:flutter/material.dart';
import 'package:hifixit/app/controllers/firebase_api.dart';
import 'package:hifixit/app/models/Customer.dart';
import 'package:hifixit/app/models/Technician.dart';
import 'package:hifixit/app/modules/technician/modules/chat/views/chat_body_widget.dart';

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
          child: StreamBuilder<List<Customer>>(
            stream: FirebaseApi.getCustomersChatList(),
            builder: (context, snapshotCust) {
              // print(snapshotCust.data);
              switch (snapshotCust.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  if (snapshotCust.hasError) {
                    print(snapshotCust.error);
                    return buildText('Something Went Wrong Try later');
                  } else {
                    final customer = snapshotCust.data;

                    if (customer!.isEmpty) {
                      return buildText('No Users Found');
                    } else {
                      return Column(
                        children: [ChatBodyWidget(customers: customer)],
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
