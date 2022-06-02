import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hifixit/app/modules/technician/modules/pending/controllers/booking_controller.dart';
import 'package:hifixit/app/services/global.dart';
import 'package:intl/intl.dart';

class ReviewBookingInfoPage extends StatefulWidget {
  const ReviewBookingInfoPage({
    Key? key,
    required this.bookId,
    // required this.status,
    // required this.bookStat,
  }) : super(key: key);

  final String bookId;
  // final String status;
  // final String bookStat;

  @override
  State<ReviewBookingInfoPage> createState() => _ReviewBookingInfoPageState();
}

class _ReviewBookingInfoPageState extends State<ReviewBookingInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("Book Info"),
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection("Booking")
              .doc(widget.bookId)
              .snapshots(),
          builder: (context, snapshotBook) {
            if (snapshotBook.connectionState == ConnectionState.active) {
              return Container(
                // height: MediaQuery.of(context).size.height,
                color: Colors.white,
                child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection("Technician")
                        .doc(snapshotBook.data?["techId"])
                        .snapshots(),
                    builder: (context, snapshotTech) {
                      if (snapshotBook.connectionState ==
                          ConnectionState.active) {
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
                                    offset: const Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundColor: const Color(0xFF7B4067),
                                    backgroundImage: snapshotTech
                                            .data?['techPicture'].isEmpty
                                        ? null
                                        : NetworkImage(snapshotTech
                                            .data!['techPicture']
                                            .toString()),
                                    child: snapshotTech
                                            .data?['techPicture'].isNotEmpty
                                        ? null
                                        : const Icon(
                                            Icons.account_circle_rounded,
                                            color: Color.fromARGB(
                                                255, 156, 156, 156),
                                            size: 50,
                                          ),
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        (snapshotTech.data?["techFName"]
                                                    .isNotEmpty ||
                                                snapshotTech.data?["techLName"]
                                                    .isNotEmpty)
                                            ? Text(
                                                snapshotTech
                                                        .data?["techFName"] +
                                                    " " +
                                                    snapshotTech
                                                        .data?["techLName"],
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color.fromARGB(
                                                        255, 63, 63, 63)),
                                              )
                                            : Text("UNKNOWN"),
                                        const SizedBox(height: 10),
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFBF84B1),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(30),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.3),
                                                spreadRadius: 1,
                                                blurRadius: 2,
                                                offset: const Offset(0,
                                                    2), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                snapshotTech.data?[
                                                            "techCategory"] ==
                                                        "Washing Machine"
                                                    ? Icons
                                                        .local_laundry_service_outlined
                                                    : snapshotTech.data?[
                                                                "techCategory"] ==
                                                            "Air Conditioner"
                                                        ? Icons.ac_unit_rounded
                                                        : Icons.build_rounded,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                              Text(
                                                snapshotTech.data?[
                                                        "techCategory"] ??
                                                    "",
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
                                  height:
                                      MediaQuery.of(context).size.height * 0.9,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 241, 241, 241),
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
                                          DocumentSnapshot<
                                              Map<String, dynamic>>>(
                                      stream: FirebaseFirestore.instance
                                          .collection("Customer")
                                          .doc(snapshotBook.data?["custId"])
                                          .snapshots(),
                                      builder: (context, snapshotCust) {
                                        return Column(
                                          children: [
                                            // Row(),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text("Date"),
                                            ),
                                            Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(30),
                                                ),
                                              ),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                // horizontal: 20,
                                                vertical: 5,
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 20,
                                                vertical: 1,
                                              ),
                                              child: TextFormField(
                                                enabled: false,
                                                decoration: InputDecoration(
                                                  fillColor: Colors.white,
                                                  border: InputBorder.none,
                                                  hintText: DateFormat(
                                                          'MMM dd yyyy')
                                                      .format(
                                                        snapshotBook
                                                            .data?["bookDate"]
                                                            .toDate(),
                                                      )
                                                      .toString(),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text("Time"),
                                            ),
                                            Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(30),
                                                ),
                                              ),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                // horizontal: 20,
                                                vertical: 5,
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 20,
                                                vertical: 1,
                                              ),
                                              child: TextFormField(
                                                enabled: false,
                                                decoration: InputDecoration(
                                                  fillColor: Colors.white,
                                                  border: InputBorder.none,
                                                  hintText: DateFormat('hh:mm')
                                                      .format(
                                                        snapshotBook
                                                            .data?["bookDate"]
                                                            .toDate(),
                                                      )
                                                      .toString(),
                                                ),
                                              ),
                                            ),
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
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                // horizontal: 20,
                                                vertical: 5,
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 20,
                                                vertical: 1,
                                              ),
                                              child: TextFormField(
                                                enabled: false,
                                                decoration: InputDecoration(
                                                  fillColor: Colors.white,
                                                  border: InputBorder.none,
                                                  hintText: snapshotBook
                                                      .data?['location'],
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
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                // horizontal: 20,
                                                vertical: 5,
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 20,
                                                vertical: 1,
                                              ),
                                              child: TextFormField(
                                                enabled: false,
                                                decoration: InputDecoration(
                                                  fillColor: Colors.white,
                                                  border: InputBorder.none,
                                                  hintText: snapshotBook.data?[
                                                          "locationDetail"] ??
                                                      "",
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
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                // horizontal: 20,
                                                vertical: 5,
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 20,
                                                vertical: 1,
                                              ),
                                              child: TextFormField(
                                                enabled: false,
                                                maxLines: 4,
                                                decoration: InputDecoration(
                                                  fillColor: Colors.white,
                                                  border: InputBorder.none,
                                                  hintText: snapshotBook.data?[
                                                          "reparationDetail"] ??
                                                      "",
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text("Paid Status"),
                                            ),
                                            Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(30),
                                                ),
                                              ),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                // horizontal: 20,
                                                vertical: 5,
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 20,
                                                vertical: 1,
                                              ),
                                              child: TextFormField(
                                                enabled: false,
                                                decoration: InputDecoration(
                                                  fillColor: Colors.white,
                                                  border: InputBorder.none,
                                                  hintText: snapshotBook.data?[
                                                          "paidStatus"] ??
                                                      "",
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            RatingBar.builder(
                                              ignoreGestures: true,
                                              itemSize: 30,
                                              initialRating: snapshotBook
                                                  .data!["rate"]
                                                  .toDouble(),
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 3.0,
                                                      vertical: 3.0),
                                              itemBuilder: (context, _) =>
                                                  const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (rating) {
                                                // print(rating);
                                              },
                                            ),
                                          ],
                                        );
                                      }),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
