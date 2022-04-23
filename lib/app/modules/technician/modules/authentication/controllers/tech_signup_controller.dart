import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hifixit/app/modules/technician/modules/authentication/views/category_info_screen.dart';
import 'package:hifixit/app/services/global.dart';
import 'package:hifixit/app/widgets/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

saveTechInfoNow(
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

  User? firebaseUser;
  await fAuth
      .createUserWithEmailAndPassword(
    email: emailInput.trim(),
    password: passwordInput.trim(),
  )
      .then((auth) {
    firebaseUser = auth.user;
  }).catchError((msg) {
    Navigator.pop(context);
    Fluttertoast.showToast(msg: "Error: " + msg.toString());
  });

  if (firebaseUser != null) {
    FirebaseFirestore.instance
        .collection("Technician")
        .doc(firebaseUser!.uid)
        .set({
      "techId": firebaseUser!.uid,
      "techFName": fNameInput.trim(),
      "techLName": lNameInput.trim(),
      "techEmail": emailInput.trim(),
      "techPhone": phoneInput.trim(),
      "techStatus": "Off",
      "techCategory": ""
    });

    // Save locally
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.setString("uid", firebaseUser!.uid);
    await sharedPreferences!
        .setString("name", fNameInput.trim() + " " + lNameInput.trim());
    await sharedPreferences!.setString("fname", fNameInput.trim());
    await sharedPreferences!.setString("lname", lNameInput.trim());
    await sharedPreferences!.setString("phone", phoneInput.trim());
    await sharedPreferences!.setString("email", firebaseUser!.email.toString());
    await sharedPreferences!.setString("type", "tech");
  } else {
    Fluttertoast.showToast(msg: "Account has not been created.");
  }

  currentFirebaseUser = firebaseUser;
  Fluttertoast.showToast(msg: "Account has been created.");
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (c) => const CategoryInfoRegistScreen(),
    ),
  );
}
