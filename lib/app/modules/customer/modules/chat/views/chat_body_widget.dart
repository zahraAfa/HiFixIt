import 'package:flutter/material.dart';
import 'package:hifixit/app/models/Customer.dart';

class ChatBodyWidget extends StatelessWidget {
  final List<Customer> customers;

  const ChatBodyWidget({
    required this.customers,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Expanded(
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
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
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final customer = customers[index];

          return Container(
            height: 75,
            child: ListTile(
              onTap: () {
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => ChatPage(customer: customer),
                // ));
              },
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(customer.custPicture!),
              ),
              title: Text(customer.custFName! + '' + customer.custLName!),
            ),
          );
        },
        itemCount: customers.length,
      );
}
