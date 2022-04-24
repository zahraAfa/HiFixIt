import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hifixit/app/models/Rates.dart';
import 'package:hifixit/app/services/global.dart';
import 'package:hifixit/app/widgets/progress_dialog.dart';
import 'package:intl/intl.dart';

class ProfileTabPage extends StatefulWidget {
  const ProfileTabPage({Key? key}) : super(key: key);

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
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection("Technician")
              .doc(currentFirebaseUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return ProgressDialog(message: "No data");
            }
            return Container(
              color: Color.fromARGB(255, 241, 241, 241),
              // width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF7B4067),
                          Color(0xFFEF8A56),
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
                            backgroundColor: Color(0xFF7B4067),
                            backgroundImage: snapshot
                                    .data!['techPicture'].isEmpty
                                ? null
                                : NetworkImage(
                                    snapshot.data!['techPicture'].toString()),
                            child: snapshot.data!['techPicture'].isNotEmpty
                                ? null
                                : Icon(
                                    Icons.account_circle_rounded,
                                    color: Color.fromARGB(255, 156, 156, 156),
                                    size: 50,
                                  ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            snapshot.data!["techFName"] +
                                " " +
                                snapshot.data!["techLName"],
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 20.0,
                            ),
                          ),
                          Text(
                            "Verified",
                            style: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          RatingBar.builder(
                            ignoreGestures: true,
                            itemSize: 30,
                            initialRating: snapshot.data!["rating"],
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(
                                horizontal: 3.0, vertical: 3.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
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
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 241, 241, 241),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Color(0xFFBF84B1),
                            child: Icon(
                              Icons.local_laundry_service_outlined,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            snapshot.data!["techCategory"],
                            style: TextStyle(
                              color: Colors.grey.shade600,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 280),
                    child: ListView.builder(
                      itemCount: _rates.length,
                      itemBuilder: (BuildContext context, int index) =>
                          StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("Rates")
                                  .where("techId",
                                      isEqualTo: currentFirebaseUser!.uid)
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snap) {
                                if (!snap.hasData) {
                                  return ProgressDialog(message: "No data");
                                }
                                return RateCard(_rates[index] as Rates);
                              }),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  Future getAllRating() async {
    var data = await FirebaseFirestore.instance
        .collection("Technician")
        .doc(currentFirebaseUser!.uid)
        .collection("Rates")
        .orderBy("created_at", descending: true)
        .get();
    setState(() {
      _rates = List.from(data.docs.map((doc) => Rates.fromSnapshot(doc)));
      print(_rates);
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
      padding: EdgeInsets.symmetric(vertical: 1, horizontal: 20),
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
                        return ProgressDialog(message: "No data");
                      }
                      return Text(
                        snapshot.data!["custFName"] +
                            " " +
                            snapshot.data!["custLName"],
                        style: TextStyle(fontSize: 20),
                      );
                    }),
                Text(
                  DateFormat('MM/dd/yyyy')
                      .format(_rateData.created_at!)
                      .toString(),
                  style: TextStyle(color: Color(0xFFD96464)),
                ),
                SizedBox(
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
                    itemPadding:
                        EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
