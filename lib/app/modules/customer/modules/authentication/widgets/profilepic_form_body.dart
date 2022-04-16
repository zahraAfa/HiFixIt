import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hifixit/app/modules/customer/modules/authentication/widgets/log_reg_submit_btn.dart';
import 'package:hifixit/app/services/global.dart';
import 'package:hifixit/app/modules/splashScreen/views/splash_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:shared_preferences/shared_preferences.dart';

class ProfPicFormBody extends StatefulWidget {
  const ProfPicFormBody({Key? key}) : super(key: key);

  @override
  State<ProfPicFormBody> createState() => _ProfPicFormBodyState();
}

class _ProfPicFormBodyState extends State<ProfPicFormBody> {
  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();
  String custImageUrl = '';

  Future<void> _getImage() async {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);
    if (imageXFile != null) {
      setState(() {
        imageXFile;
      });
    } else {
      print("No image selected");
    }
  }

  saveNewInfo() async {
    if (imageXFile != null) {
      // print(imageXFile!.name);
      // String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      String fileName = currentFirebaseUser!.uid;
      fStorage.Reference reference = fStorage.FirebaseStorage.instance
          .ref()
          .child("Customer")
          .child("profilePics")
          .child(fileName);

      fStorage.UploadTask uploadTask =
          reference.putFile(File(imageXFile!.path));

      fStorage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      await taskSnapshot.ref.getDownloadURL().then((url) {
        custImageUrl = url;
      });
    } else {
      print("No image selected");
    }

    Map<String, dynamic> custNewMap = {
      "custPicture": custImageUrl,
    };

    FirebaseFirestore.instance
        .collection("Customer")
        .doc(currentFirebaseUser!.uid)
        .update(custNewMap);

    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.setString("pic", custImageUrl);

    Fluttertoast.showToast(msg: "Welcome to HiFixIt");
    Navigator.push(
        context, MaterialPageRoute(builder: (c) => const MySplashScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      minChildSize: 0.7,
      maxChildSize: 0.75,
      initialChildSize: 0.7,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 510,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      InkWell(
                        onTap: () {
                          _getImage();
                        },
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.20,
                          backgroundColor: Colors.white,
                          backgroundImage: imageXFile == null
                              ? null
                              : FileImage(File(imageXFile!.path)),
                          child: imageXFile == null
                              ? Icon(
                                  Icons.add_photo_alternate_outlined,
                                  size:
                                      MediaQuery.of(context).size.width * 0.20,
                                  color: Color(0xFFBF84B1),
                                )
                              : null,
                        ),
                      ),
                      const SizedBox(height: 25),
                      SizedBox(
                        height: 55,
                        child: LogRegSubmitBtn(
                          label: 'Sign up',
                          press: () {
                            saveNewInfo();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
