import 'package:flutter/material.dart';
import 'package:hifixit/app/modules/customer/widgets/menu_drawer.dart';
import 'package:hifixit/app/modules/customer/modules/schedule/views/schedule_tab.dart';
import 'package:intl/intl.dart';
import 'package:hifixit/app/models/Booking.dart';
import 'package:hifixit/app/services/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PendingBookingPage extends StatefulWidget {
  const PendingBookingPage({Key? key}) : super(key: key);

  @override
  State<PendingBookingPage> createState() => _PendingBookingPageState();
}

class _PendingBookingPageState extends State<PendingBookingPage> {
  List<Object> _bookings = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getAllBooking();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: BackButton(
        //   onPressed: () {
        //     Navigator.pop(context,
        //         MaterialPageRoute(builder: (c) => const ScheduleTabPage()));
        //   },
        // ),
        elevation: 0,
        title: const Text("Pending"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                ),
                // height: 200,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: ListView.builder(
                        // shrinkWrap: true,
                        itemCount: _bookings.length,
                        itemBuilder: (BuildContext context, int index) =>
                            StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("Booking")
                                    .where("custId",
                                        isEqualTo: currentFirebaseUser!.uid)
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snap) {
                                  if (!snap.hasData) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (snap.connectionState ==
                                          ConnectionState.done ||
                                      snap.hasData ||
                                      snap.data != null) {
                                    return BookCardList(
                                        _bookings[index] as Booking);
                                  }
                                  return const Center(
                                      child: const CircularProgressIndicator());
                                }),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future getAllBooking() async {
    var data = await FirebaseFirestore.instance
        .collection("Booking")
        .where("custId", isEqualTo: currentFirebaseUser!.uid)
        .where("bookStatus", isEqualTo: "Pending")
        .orderBy("bookDate", descending: false)
        .get();
    setState(() {
      _bookings += List.from(data.docs.map((doc) => Booking.fromSnapshot(doc)));
      // print(_bookings);
    });
  }
}

class BookCardList extends StatelessWidget {
  const BookCardList(
    this._bookingsData,
  );

  final Booking _bookingsData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 20),
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('dd')
                          .format(_bookingsData.bookDate!)
                          .toString(),
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      DateFormat('MMM')
                          .format(_bookingsData.bookDate!)
                          .toString(),
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      DateFormat('yy')
                          .format(_bookingsData.bookDate!)
                          .toString(),
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 80,
                    padding: const EdgeInsets.all(5),
                    child: VerticalDivider(
                      color: Colors.grey.shade300,
                      thickness: 3,
                      indent: 0,
                      endIndent: 0,
                      width: 20,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                        stream: FirebaseFirestore.instance
                            .collection("Technician")
                            .doc(_bookingsData.techId.toString())
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                                child: const CircularProgressIndicator());
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data!["techFName"] +
                                    " " +
                                    snapshot.data!["techLName"],
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                snapshot.data!["techCategory"],
                                style: TextStyle(
                                  color: Color(0xFFD96464),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          );
                        }),
                    Text(
                      _bookingsData.bookStatus.toString(),
                      style: TextStyle(
                        color: Color(0xFFD96464),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      DateFormat('hh:mm')
                          .format(_bookingsData.bookDate!)
                          .toString(),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
