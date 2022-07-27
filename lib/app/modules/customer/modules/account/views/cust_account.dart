import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hifixit/app/modules/Customer/modules/account/widgets/account_edit_btn.dart';
import 'package:hifixit/app/modules/Customer/modules/account/widgets/account_input.dart';
import 'package:hifixit/app/modules/customer/widgets/menu_drawer.dart';
import 'package:hifixit/app/services/global.dart';

class CustAccount extends StatefulWidget {
  const CustAccount({Key? key}) : super(key: key);

  @override
  State<CustAccount> createState() => _CustAccountState();
}

class _CustAccountState extends State<CustAccount> {
  final TextEditingController firstNameC = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // DocumentSnapshot? _userInfo;

  // Future getCustData() async {
  //   _userInfo = await FirebaseFirestore.instance
  //       .collection("Customer")
  //       .doc(currentFirebaseUser!.uid)
  //       .get();
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   getCustData();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: MenuDrawer(),
      backgroundColor: const Color.fromARGB(255, 229, 229, 229),
      appBar: AppBar(
        title: const Text("Account"),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection("Customer")
                .doc(currentFirebaseUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              return Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 50.0),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    InkWell(
                      child: CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 0.20,
                        backgroundColor: Colors.white,
                        backgroundImage: snapshot.data!['custPicture'].isEmpty
                            ? null
                            : NetworkImage(
                                snapshot.data!['custPicture'].toString()),
                        child: snapshot.data!['custPicture'].isNotEmpty
                            ? null
                            : Icon(
                                Icons.person,
                                size: MediaQuery.of(context).size.width * 0.20,
                                color: const Color(0xFFBF84B1),
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(
                              "First Name",
                              textAlign: TextAlign.start,
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          AccountInputCust(
                            onChanged: (value) {},
                            // hintTitle: _userInfo!["custFName"] ?? "",
                            hintTitle: snapshot.data!['custFName'].toString(),
                            keyboardType: TextInputType.text,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(
                              "Last Name",
                              textAlign: TextAlign.start,
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          AccountInputCust(
                            onChanged: (value) {},
                            hintTitle: snapshot.data!['custLName'].toString(),
                            keyboardType: TextInputType.text,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(
                              "Email",
                              textAlign: TextAlign.start,
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          AccountInputCust(
                            onChanged: (value) {},
                            hintTitle: snapshot.data!['custEmail'].toString(),
                            keyboardType: TextInputType.text,
                            enabled: false,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(
                              "Phone No.",
                              textAlign: TextAlign.start,
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          AccountInputCust(
                            onChanged: (value) {},
                            hintTitle: snapshot.data!['custPhone'].toString(),
                            keyboardType: TextInputType.text,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 40,
                      child: AccountEditBtn(
                        label: 'Save Changes',
                        press: () {},
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
