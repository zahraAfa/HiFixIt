import 'package:flutter/material.dart';
import 'package:hifixit/app/modules/customer/modules/booking/controllers/booking_controller.dart';
import 'package:hifixit/app/modules/customer/widgets/button_widget.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({Key? key}) : super(key: key);

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime? date;

  String getText() {
    if (date == null) {
      return 'Select Date';
    } else {
      // return '${date.month} / ${date.day} / ${date.year}';
      // DateTime selectedDT=pickedDateTime;
      // FirebaseFirestore.instance.collection('Booking').doc('').setData({
      // 'date_time': selectedDT
      // });
      return DateFormat('dd MMM yyyy').format(date!);
    }
  }

  @override
  Widget build(BuildContext context) => ButtonHeaderWidget(
        title: 'Date',
        text: getText(),
        onClicked: () {
          pickDate(context);
        },
      );

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: date ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (newDate == null) return;
    setState(() => date = newDate);
    setBookingDate(date);
  }
}
