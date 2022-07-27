import 'package:flutter/material.dart';
import 'package:hifixit/app/models/Customer.dart';
import 'package:hifixit/app/models/Technician.dart';
import 'package:hifixit/app/modules/customer/modules/chat/views/chat_page.dart';

class ChatBodyWidget extends StatelessWidget {
  final List<Technician> technicians;

  const ChatBodyWidget({
    required this.technicians,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Expanded(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: buildChats(),
        ),
      );

  Widget buildChats() => ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final technician = technicians[index];

          return Container(
            height: 75,
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChatPage(technician: technician),
                ));
              },
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey[200],
                // backgroundImage: technician.techPicture ? NetworkImage(technician.techPicture!): ,
                backgroundImage: technician.techPicture!.isEmpty
                    ? null
                    : NetworkImage(technician.techPicture!.toString()),
                child: technician.techPicture!.isNotEmpty
                    ? null
                    : Icon(
                        Icons.person,
                        size: MediaQuery.of(context).size.width * 0.10,
                        color: const Color(0xFFBF84B1),
                      ),
              ),
              title: Text(technician.techFName! + ' ' + technician.techLName!),
            ),
          );
        },
        itemCount: technicians.length,
      );
}
