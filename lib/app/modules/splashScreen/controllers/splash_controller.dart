import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hifixit/app/controllers/assistant_method.dart';
import 'package:hifixit/app/modules/customer/modules/mainScreen/views/main_screen_cust.dart';
import 'package:hifixit/app/modules/technician/modules/mainScreens/main_screens_tech.dart';
import 'package:hifixit/app/modules/welcome/views/welcome.dart';
import 'dart:async';

import 'package:hifixit/app/services/global.dart';

startTimer(context) {
  fAuth.currentUser != null
      ? AssistantMethod.readCurrentOnlineCustInfo()
      : null;

  Timer(const Duration(seconds: 1), () async {
    if (await fAuth.currentUser != null) {
      currentFirebaseUser = fAuth.currentUser;
      DatabaseReference custRef =
          FirebaseDatabase.instance.ref().child("Customer");

      custRef.child(currentFirebaseUser!.uid).once().then((custKey) {
        final snap = custKey.snapshot;

        if (snap.value != null) {
          //if customer
          print("This is customer");
          Navigator.push(
              context, MaterialPageRoute(builder: (c) => MainScreenCust()));
        } else {
          //if tech
          print("This is technician");
          Navigator.push(
              context, MaterialPageRoute(builder: (c) => MainScreenTech()));
        }
      });
    } else {
      Navigator.push(
          context,
          // MaterialPageRoute(builder: (c) => const LoginScreenTech()));
          MaterialPageRoute(
              builder: (c) => const WelcomingPage(
                    title: 'HiFixIt',
                  )));
    }
  });
}
