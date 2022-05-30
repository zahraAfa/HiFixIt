import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hifixit/app/models/Booking.dart';
import 'package:hifixit/app/services/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryTabPage extends StatefulWidget {
  const HistoryTabPage({Key? key}) : super(key: key);

  @override
  State<HistoryTabPage> createState() => _HistoryTabPageState();
}

class _HistoryTabPageState extends State<HistoryTabPage> {
  List<Object> _histories = [];

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
                        itemCount: _histories.length,
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
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (snap.connectionState ==
                                          ConnectionState.done ||
                                      snap.hasData ||
                                      snap.data != null) {
                                    return BookCardList(
                                        _histories[index] as Booking);
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
        .where("techId", isEqualTo: currentFirebaseUser!.uid)
        .where("bookStatus",
            whereIn: ["Ongoing", "Canceled", "Completed", "Rejected"])
        .orderBy("bookDate", descending: false)
        .get();
    setState(() {
      _histories +=
          List.from(data.docs.map((doc) => Booking.fromSnapshot(doc)));
      // print(_histories);
    });
  }
}

class BookCardList extends StatelessWidget {
  const BookCardList(
    this._historiesData,
  );

  final Booking _historiesData;

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
                          .format(_historiesData.bookDate!)
                          .toString(),
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      DateFormat('MMM')
                          .format(_historiesData.bookDate!)
                          .toString(),
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      DateFormat('yy')
                          .format(_historiesData.bookDate!)
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
                            .collection("Customer")
                            .doc(_historiesData.custId.toString())
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
                      _historiesData.bookStatus.toString(),
                      style: TextStyle(
                        color: _historiesData.bookStatus.toString() ==
                                "Canceled"
                            ? Color(0xFFD96464)
                            : _historiesData.bookStatus.toString() == "Ongoing"
                                ? Color(0xFF2FB83D)
                                : Colors.grey.shade500,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      DateFormat('hh:mm')
                          .format(_historiesData.bookDate!)
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
