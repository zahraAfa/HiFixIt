import 'package:flutter/material.dart';
import 'package:hifixit/app/controllers/firebase_api.dart';
import 'package:hifixit/app/models/Customer.dart';
import 'package:hifixit/app/modules/customer/modules/chat/views/chat_body_widget.dart';

class ChatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.blue,
        body: SafeArea(
          child: StreamBuilder<List<Customer>>(
            stream: FirebaseApi.getCustomers(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return buildText('Something Went Wrong Try later');
                  } else {
                    final customer = snapshot.data;

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
