import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hifixit/app/modules/splashScreen/views/splash_screen.dart';
import 'package:hifixit/app/services/global.dart';
import 'package:hifixit/app/widgets/progress_dialog.dart';

loginTechNow({emailInput, passwordInput, context}) async {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext c) {
        return ProgressDialog(
          message: "Processing, Please wait...",
        );
      });
  final User? firebaseUser = (await fAuth
          .signInWithEmailAndPassword(
    email: emailInput.trim(),
    password: passwordInput.trim(),
  )
          .catchError((msg) {
    Navigator.pop(context);
    Fluttertoast.showToast(msg: "Error: " + msg.toString());
  }))
      .user;

  if (firebaseUser != null) {
    FirebaseFirestore.instance
        .collection("Technician")
        .doc(firebaseUser.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        readDataAndSetLocally(firebaseUser).then((value) {
          currentFirebaseUser = firebaseUser;
          Fluttertoast.showToast(msg: "Login Successful.");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (c) => const MySplashScreen(),
            ),
          );
        });
      } else {
        Fluttertoast.showToast(msg: "No record exist with this email");
        fAuth.signOut();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (c) => const MySplashScreen(),
          ),
        );
      }
    });
  } else {
    Navigator.pop(context);
    Fluttertoast.showToast(msg: "Invalid data.");
  }
}

Future readDataAndSetLocally(User currentUser) async {
  await FirebaseFirestore.instance
      .collection("Technician")
      .doc(currentUser.uid)
      .get()
      .then((snapshot) async {
    await sharedPreferences!.setString("uid", currentUser.uid);
    await sharedPreferences!.setString("email", snapshot.data()!["techEmail"]);
    await sharedPreferences!.setString("name",
        snapshot.data()!["techFName"] + " " + snapshot.data()!["techLName"]);
    await sharedPreferences!.setString("fname", snapshot.data()!["techFName"]);
    await sharedPreferences!.setString("lname", snapshot.data()!["techLName"]);
    await sharedPreferences!.setString("phone", snapshot.data()!["techPhone"]);
    await sharedPreferences!.setString("type", "tech");
  });
}
