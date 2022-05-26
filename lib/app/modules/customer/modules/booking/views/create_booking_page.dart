import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hifixit/app/modules/customer/widgets/date_picker_widget.dart';
import 'package:hifixit/app/modules/customer/widgets/time_picker_widget.dart';
import 'package:hifixit/app/services/global.dart';

class CreateBookingPage extends StatefulWidget {
  const CreateBookingPage({
    Key? key,
    required this.techId,
  }) : super(key: key);

  final String techId;

  @override
  State<CreateBookingPage> createState() => _CreateBookingPageState();
}

class _CreateBookingPageState extends State<CreateBookingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("Create Booking"),
      ),
      body: Container(
        // height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection("Technician")
                .doc(widget.techId)
                .snapshots(),
            builder: (context, snapshot) {
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 241, 241, 241),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset:
                              const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: const Color(0xFF7B4067),
                          backgroundImage: snapshot.data?['techPicture'].isEmpty
                              ? null
                              : NetworkImage(
                                  snapshot.data!['techPicture'].toString()),
                          child: snapshot.data?['techPicture'].isNotEmpty
                              ? null
                              : const Icon(
                                  Icons.account_circle_rounded,
                                  color: Color.fromARGB(255, 156, 156, 156),
                                  size: 50,
                                ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data?["techFName"] +
                                    " " +
                                    snapshot.data?["techLName"],
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(255, 63, 63, 63)),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFBF84B1),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: const Offset(
                                          0, 2), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      snapshot.data?["techCategory"] ==
                                              "Washing Machine"
                                          ? Icons.local_laundry_service_outlined
                                          : snapshot.data?["techCategory"] ==
                                                  "Air Conditioner"
                                              ? Icons.ac_unit_rounded
                                              : Icons.build_rounded,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    Text(
                                      snapshot.data?["techCategory"],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.9,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 241, 241, 241),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(
                                  0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: StreamBuilder<
                                DocumentSnapshot<Map<String, dynamic>>>(
                            stream: FirebaseFirestore.instance
                                .collection("Customer")
                                .doc(currentFirebaseUser!.uid)
                                .snapshots(),
                            builder: (context, snapshot) {
                              return Column(
                                children: [
                                  // Row(),
                                  DatePickerWidget(),
                                  TimePickerWidget(),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Your Location"),
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                      // horizontal: 20,
                                      vertical: 5,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 1,
                                    ),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        border: InputBorder.none,
                                        hintText:
                                            snapshot.data?['currLocation'],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Location Detail"),
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                      // horizontal: 20,
                                      vertical: 5,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 1,
                                    ),
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                        fillColor: Colors.white,
                                        border: InputBorder.none,
                                        // hintText: 'Enter a search term',
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Reparation Detail"),
                                  ),
                                  Container(
                                    height: 100,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                      // horizontal: 20,
                                      vertical: 5,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 1,
                                    ),
                                    child: TextFormField(
                                      maxLines: 4,
                                      decoration: const InputDecoration(
                                        fillColor: Colors.white,
                                        border: InputBorder.none,
                                        // hintText: 'Enter a search term',
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton.icon(
                                    icon:
                                        const Icon(Icons.bookmark_add_outlined),
                                    onPressed: () {},
                                    label: const Text("Book"),
                                    style: ButtonStyle(
                                        minimumSize: MaterialStateProperty.all(
                                            Size(300, 50)),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          const Color(0xFFA74385),
                                        ),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                side: BorderSide(
                                                    color:
                                                        Color(0xFFA74385))))),
                                  ),
                                ],
                              );
                            }),
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
