import 'package:flutter/material.dart';
import 'package:hifixit/app/controllers/firebase_api.dart';
import 'package:hifixit/app/models/Message.dart';
import 'package:hifixit/app/modules/customer/modules/chat/views/message_widget.dart';
import 'package:hifixit/app/services/global.dart';

// import '../data.dart';

class MessagesWidget extends StatelessWidget {
  final String techId;

  const MessagesWidget({
    required this.techId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => StreamBuilder<List<Message>>(
        stream: FirebaseApi.getTechMessages(techId, currentFirebaseUser!.uid),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                print(snapshot.error);
                return buildText('Something Went Wrong Try later');
              } else {
                final messages = snapshot.data;

                return messages!.isEmpty
                    ? buildText('Say Hi..')
                    : ListView.builder(
                        physics: BouncingScrollPhysics(),
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];

                          return MessageWidget(
                            message: message,
                            isMe: message.userId == currentFirebaseUser!.uid,
                          );
                        },
                      );
              }
          }
        },
      );

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24),
        ),
      );
}
