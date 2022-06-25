import 'package:flutter/material.dart';
import 'package:hifixit/app/models/Customer.dart';
import 'package:hifixit/app/models/Technician.dart';
import 'package:hifixit/app/modules/technician/modules/chat/views/chat_page.dart';

class ChatBodyWidget extends StatelessWidget {
  final List<Customer> customers;

  const ChatBodyWidget({
    required this.customers,
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
          final customer = customers[index];

          return Container(
            height: 75,
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChatPage(customer: customer),
                ));
              },
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey[200],
                // backgroundImage: customer.custPicture ? NetworkImage(customer.custPicture!): ,
                backgroundImage: customer.custPicture!.isEmpty
                    ? null
                    : NetworkImage(customer.custPicture!.toString()),
                child: customer.custPicture!.isNotEmpty
                    ? null
                    : Icon(
                        Icons.person,
                        size: MediaQuery.of(context).size.width * 0.10,
                        color: const Color(0xFFBF84B1),
                      ),
              ),
              title: Text(customer.custFName! + ' ' + customer.custLName!),
            ),
          );
        },
        itemCount: customers.length,
      );
}
