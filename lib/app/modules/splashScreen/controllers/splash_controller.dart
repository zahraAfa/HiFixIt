import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

      if (sharedPreferences!.getString("type") != "tech") {
        // print(sharedPreferences!.getString("type"));
        // print(sharedPreferences!.getString("name"));
        // print(sharedPreferences!.getString("email"));
        //if customer
        print("This is customer");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (c) => MainScreenCust()),
            (Route<dynamic> route) => false);
      } else {
        //if tech
        print("This is technician");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (c) => MainScreenTech()),
            (Route<dynamic> route) => false);
      }
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (c) => const WelcomingPage(
                    title: 'HiFixIt',
                  )),
          (Route<dynamic> route) => false);
    }
  });
}
