import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hifixit/app/modules/splashScreen/views/splash_screen.dart';
import 'package:hifixit/app/services/global.dart';
import 'package:hifixit/app/widgets/progress_dialog.dart';

saveCustInfoNow(
    {context,
    emailInput,
    passwordInput,
    fNameInput,
    lNameInput,
    phoneInput}) async {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext c) {
        return ProgressDialog(
          message: "Processing, Please wait...",
        );
      });
  final User? firebaseUser = (await fAuth
          .createUserWithEmailAndPassword(
    email: emailInput.trim(),
    password: passwordInput.trim(),
  )
          .catchError((msg) {
    Navigator.pop(context);
    Fluttertoast.showToast(msg: "Error: " + msg.toString());
  }))
      .user;

  if (firebaseUser != null) {
    Map custMap = {
      "custId": firebaseUser.uid,
      "custFName": fNameInput.trim(),
      "custLName": lNameInput.trim(),
      "custEmail": emailInput.trim(),
      "custPhone": phoneInput.trim(),
    };

    DatabaseReference custRef =
        FirebaseDatabase.instance.ref().child("Customer");
    custRef.child(firebaseUser.uid).set(custMap);
  } else {
    Fluttertoast.showToast(msg: "Account has not been created.");
  }

  currentFirebaseUser = firebaseUser;
  Fluttertoast.showToast(msg: "Account has been created.");
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (c) => const MySplashScreen(),
    ),
  );
}
