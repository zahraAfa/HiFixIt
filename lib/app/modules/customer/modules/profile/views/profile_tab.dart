import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hifixit/app/models/Rates.dart';
import 'package:hifixit/app/modules/customer/modules/booking/views/create_booking_page.dart';
import 'package:hifixit/app/modules/customer/modules/chat/views/2/chat_page.dart';
import 'package:hifixit/app/services/global.dart';
import 'package:hifixit/app/widgets/progress_dialog.dart';
import 'package:intl/intl.dart';

class ProfileTabPage extends StatefulWidget {
  const ProfileTabPage({
    Key? key,
    required this.techId,
  }) : super(key: key);

  final String techId;

  @override
  State<ProfileTabPage> createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends State<ProfileTabPage> {
  List<Object> _rates = [];

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    getAllRating();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Technician Profile"),
        centerTitle: true,
        actions: [
          ElevatedButton.icon(
            icon: const Icon(Icons.chat_bubble_rounded),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    ChatPage2(techId: widget.techId.toString()),
              ));
            },
            label: const Text("Chat"),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  const Color(0xFFA74385),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide(color: Color(0xFFA74385))))),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection("Technician")
              .doc(widget.techId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.active ||
                snapshot.connectionState == ConnectionState.done) {
              return Container(
                color: const Color.fromARGB(255, 241, 241, 241),
                // width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color(0xFF7B4067),
                            const Color(0xFFEF8A56),
                          ],
                        ),
                      ),
                      height: 220,
                      width: MediaQuery.of(context).size.width,
                      child: Column(children: [
                        Container(
                          child: Column(children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: const Color(0xFF7B4067),
                              backgroundImage: snapshot
                                      .data!['techPicture'].isEmpty
                                  ? null
                                  : NetworkImage(
                                      snapshot.data!['techPicture'].toString()),
                              child: snapshot.data!['techPicture'].isNotEmpty
                                  ? null
                                  : const Icon(
                                      Icons.account_circle_rounded,
                                      color: Color.fromARGB(255, 156, 156, 156),
                                      size: 50,
                                    ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              snapshot.data!["techFName"] +
                                  " " +
                                  snapshot.data!["techLName"],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 20.0,
                              ),
                            ),
                            const Text(
                              "Verified",
                              style: TextStyle(
                                color: Colors.black38,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            RatingBar.builder(
                              ignoreGestures: true,
                              itemSize: 30,
                              initialRating:
                                  snapshot.data!["rating"].toDouble(),
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding: const EdgeInsets.symmetric(
                                  horizontal: 3.0, vertical: 3.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                // print(rating);
                              },
                            ),
                          ]),
                        ),
                      ]),
                    ),
                    Positioned(
                      left: 40,
                      right: 40,
                      top: 200,
                      child: Container(
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
                              radius: 25,
                              backgroundColor: Color(0xFFBF84B1),
                              child: snapshot.data!["techCategory"] ==
                                      "Washing Machine"
                                  ? Icon(
                                      Icons.local_laundry_service_outlined,
                                      color: Colors.white,
                                      size: 30,
                                    )
                                  : snapshot.data!["techCategory"] ==
                                          "Air Conditioner"
                                      ? Icon(
                                          Icons.ac_unit_rounded,
                                          color: Colors.white,
                                          size: 30,
                                        )
                                      : Icon(
                                          Icons.build_rounded,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              snapshot.data!["techCategory"],
                              style: TextStyle(
                                color: Colors.grey.shade600,
                              ),
                            ),
                            SizedBox(width: 17),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.bookmark_add_outlined),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (c) => CreateBookingPage(
                                              techId: snapshot.data!["techId"]
                                                  .toString(),
                                            )));
                              },
                              label: const Text("Book"),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  const Color(0xFFBF84B1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 280),
                      child: ListView.builder(
                        itemCount: _rates.length,
                        itemBuilder: (BuildContext context, int index) =>
                            StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("Rates")
                                    .where("techId", isEqualTo: widget.techId)
                                    // .where("techId",
                                    //     isEqualTo: currentFirebaseUser!.uid)
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
                                    return RateCard(_rates[index] as Rates);
                                  }
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: const CircularProgressIndicator());
          }),
    );
  }

  Future getAllRating() async {
    final String techId = widget.techId;
    var data = await FirebaseFirestore.instance
        .collection("Technician")
        .doc(techId)
        .collection("Rates")
        .orderBy("created_at", descending: true)
        .get();
    setState(() {
      _rates = List.from(data.docs.map((doc) => Rates.fromSnapshot(doc)));
    });
  }
}

class RateCard extends StatelessWidget {
  const RateCard(
    this._rateData,
  );

  final Rates _rateData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 20),
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection("Customer")
                        .doc(_rateData.custId.toString())
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return Text(
                        snapshot.data!["custFName"] +
                            " " +
                            snapshot.data!["custLName"],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    }),
                Text(
                  DateFormat('dd MMM yyyy')
                      .format(_rateData.created_at!)
                      .toString(),
                  style: const TextStyle(
                    color: Color(0xFFD96464),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: RatingBar.builder(
                    ignoreGestures: true,
                    itemSize: 30,
                    initialRating: _rateData.rate!.toDouble(),
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 3.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      // print(rating);
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
