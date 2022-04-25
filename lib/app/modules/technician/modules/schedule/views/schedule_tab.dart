import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hifixit/app/models/Booking.dart';
import 'package:hifixit/app/services/global.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class ScheduleTabPage extends StatefulWidget {
  const ScheduleTabPage({Key? key}) : super(key: key);

  @override
  State<ScheduleTabPage> createState() => _ScheduleTabPageState();
}

class _ScheduleTabPageState extends State<ScheduleTabPage> {
  List<Object> _book = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getAllBooking();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: Colors.grey.shade300,
                ),
                // height: 200,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Booked",
                      style: TextStyle(
                          color: Color(0xFF7B4067),
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: ListView.builder(
                        // shrinkWrap: true,
                        itemCount: _book.length,
                        itemBuilder: (BuildContext context, int index) =>
                            StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("Booking")
                                    .where("techId",
                                        isEqualTo: currentFirebaseUser!.uid)
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snap) {
                                  if (!snap.hasData) {
                                    print("No data");
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (snap.connectionState ==
                                          ConnectionState.done ||
                                      snap.hasData ||
                                      snap.data != null) {
                                    print(snap.data);
                                    return BookCardList(
                                        _book[index] as Booking);
                                  }
                                  print("end data");
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
        .where("techId", isEqualTo: currentFirebaseUser!.uid)
        .where("bookStatus", isEqualTo: "Booked")
        .orderBy("bookDate", descending: false)
        .get();
    setState(() {
      _book = List.from(data.docs.map((doc) => Booking.fromSnapshot(doc)));
      // print(_book);
    });
  }
}

class BookCardList extends StatelessWidget {
  const BookCardList(
    this._bookData,
  );

  final Booking _bookData;

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
                      DateFormat('dd').format(_bookData.bookDate!).toString(),
                      style: TextStyle(
                        color: Color(0xFFD96464),
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      DateFormat('MMM').format(_bookData.bookDate!).toString(),
                      style: TextStyle(
                        color: Color(0xFFD96464),
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      DateFormat('yy').format(_bookData.bookDate!).toString(),
                      style: TextStyle(
                        color: Color(0xFFD96464),
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
                            .collection("Customer")
                            .doc(_bookData.custId.toString())
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
                                snapshot.data!["custFName"] +
                                    " " +
                                    snapshot.data!["custLName"],
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          );
                        }),
                    Text(
                      DateFormat('hh:mm')
                          .format(_bookData.bookDate!)
                          .toString(),
                      style: const TextStyle(
                        color: Color(0xFFD96464),
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
