import 'package:flutter/material.dart';

class TechAccount extends StatefulWidget {
  const TechAccount({Key? key}) : super(key: key);

  @override
  State<TechAccount> createState() => _TechAccountState();
}

class _TechAccountState extends State<TechAccount> {
  final TextEditingController firstNameC = TextEditingController();

  bool _validate = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 229, 229, 229),
      appBar: AppBar(
        title: Text("Account"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          width: MediaQuery.of(context).size.width,
          // color: Color.fromARGB(255, 218, 218, 218),
          child: Column(
            children: [
              InkWell(
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.20,
                  backgroundColor: Colors.white,
                  backgroundImage: null,
                  child: Icon(
                    Icons.person,
                    size: MediaQuery.of(context).size.width * 0.20,
                    color: Color(0xFFBF84B1),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("First Name"),
                      const Text("First Name Here"),
                      Container(
                        height: 20,
                        color: Colors.red,
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Last Name"),
                      const Text("Last Name Here"),
                      Container(
                        height: 20,
                        color: Colors.red,
                      )
                    ],
                  ),
                ],
              ),
              Text("Email"),
              Text("Phone No."),
              Text("Category"),
            ],
          ),
        ),
      ),
    );
  }
}
