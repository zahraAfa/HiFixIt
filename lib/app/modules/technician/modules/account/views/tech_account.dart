import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hifixit/app/modules/technician/modules/account/widgets/account_edit_btn.dart';
import 'package:hifixit/app/modules/technician/modules/account/widgets/account_input.dart';
import 'package:hifixit/app/modules/technician/widgets/menu_drawer.dart';
import 'package:hifixit/app/services/global.dart';

class TechAccount extends StatefulWidget {
  const TechAccount({Key? key}) : super(key: key);

  @override
  State<TechAccount> createState() => _TechAccountState();
}

class _TechAccountState extends State<TechAccount> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController firstNameC = TextEditingController();
  // DocumentSnapshot? _userInfo;

  // getTechData() async {
  //   _userInfo = await FirebaseFirestore.instance
  //       .collection("Technician")
  //       .doc(currentFirebaseUser!.uid)
  //       .get();
  //   print(_userInfo!["techFName"]);
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   getTechData();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const MenuDrawer(),
      backgroundColor: const Color.fromARGB(255, 229, 229, 229),
      appBar: AppBar(
        title: const Text("Account"),
        leading: IconButton(
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection("Technician")
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
                        backgroundImage: snapshot.data!['techPicture'].isEmpty
                            ? null
                            : NetworkImage(
                                snapshot.data!['techPicture'].toString()),
                        child: snapshot.data!['techPicture'].isNotEmpty
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
                          AccountInputTech(
                            onChanged: (value) {},
                            hintTitle: snapshot.data!['techFName'].toString(),
                            // hintTitle: "fn",
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
                          AccountInputTech(
                            onChanged: (value) {},
                            hintTitle: snapshot.data!['techLName'].toString(),
                            // hintTitle: "ln",
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
                          AccountInputTech(
                            onChanged: (value) {},
                            hintTitle: snapshot.data!['techEmail'].toString(),
                            // hintTitle: "te",
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
                          AccountInputTech(
                            onChanged: (value) {},
                            hintTitle: snapshot.data!['techPhone'].toString(),
                            // hintTitle: "tp",
                            keyboardType: TextInputType.text,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(
                              "Category",
                              textAlign: TextAlign.start,
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          AccountInputTech(
                            onChanged: (value) {},
                            hintTitle:
                                snapshot.data!['techCategory'].toString(),
                            // hintTitle: "tc",
                            keyboardType: TextInputType.text,
                            enabled: false,
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
                        press: () {
                          // if ((_emailInput.isNotEmpty) &&
                          //     (_fNameInput.isNotEmpty) &&
                          //     (_lNameInput.isNotEmpty) &&
                          //     (_phoneInput.isNotEmpty) &&
                          //     (_passwordInput.isNotEmpty)) {
                          //   saveTechInfoNow(
                          //       context: context,
                          //       emailInput: _emailInput,
                          //       passwordInput: _passwordInput,
                          //       fNameInput: _fNameInput,
                          //       lNameInput: _lNameInput,
                          //       phoneInput: _phoneInput);
                          // } else {
                          //   // validateForm();
                          // }
                        },
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
