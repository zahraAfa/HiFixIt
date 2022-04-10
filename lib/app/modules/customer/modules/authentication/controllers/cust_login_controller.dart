import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hifixit/app/modules/splashScreen/views/splash_screen.dart';
import 'package:hifixit/app/services/global.dart';
import 'package:hifixit/app/widgets/progress_dialog.dart';

loginCustNow({emailInput, passwordInput, context}) async {
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
    DatabaseReference custRef =
        FirebaseDatabase.instance.ref().child("Customer");
    custRef.child(firebaseUser.uid).once().then((custKey) {
      final snap = custKey.snapshot;
      if (snap.value != null) {
        currentFirebaseUser = firebaseUser;
        Fluttertoast.showToast(msg: "Login Successful.");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => const MySplashScreen(),
          ),
        );
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
