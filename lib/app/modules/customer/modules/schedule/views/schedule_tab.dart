import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hifixit/app/services/global.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleTabPage extends StatefulWidget {
  const ScheduleTabPage({Key? key}) : super(key: key);

  @override
  State<ScheduleTabPage> createState() => _ScheduleTabPageState();
}

class _ScheduleTabPageState extends State<ScheduleTabPage> {
  List<Object> _book = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Schedules"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
            ),
            Text("Booked"),
            ListView.builder(
              itemBuilder: (BuildContext context, int index) => StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Booking")
                      .where("custId", isEqualTo: currentFirebaseUser!.uid)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snap) {
                    if (!snap.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snap.connectionState == ConnectionState.done ||
                        snap.hasData ||
                        snap.data != null) {
                      print(snap.data);
                      return SizedBox();
                    }
                    return const Center(
                        child: const CircularProgressIndicator());
                  }),
            )
          ],
        ),
      ),
    );
  }
}
