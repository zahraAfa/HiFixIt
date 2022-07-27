import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hifixit/app/modules/technician/modules/authentication/widgets/log_reg_submit_btn.dart';
import 'package:hifixit/app/services/global.dart';
import 'package:hifixit/app/modules/splashScreen/views/splash_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:shared_preferences/shared_preferences.dart';

class CategoryFormBody extends StatefulWidget {
  const CategoryFormBody({Key? key}) : super(key: key);

  @override
  State<CategoryFormBody> createState() => _CategoryFormBodyState();
}

class _CategoryFormBodyState extends State<CategoryFormBody> {
  List<String> categoryType = ["Washing Machine", "Air Conditioner"];
  String? selectedCategoryType;

  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();
  String techImageUrl = '';

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

  saveCategoryInfo() async {
    if (imageXFile != null) {
      // print(imageXFile!.name);
      // String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      String fileName = currentFirebaseUser!.uid;
      fStorage.Reference reference = fStorage.FirebaseStorage.instance
          .ref()
          .child("Technician")
          .child("profilePics")
          .child(fileName);

      fStorage.UploadTask uploadTask =
          reference.putFile(File(imageXFile!.path));

      fStorage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      await taskSnapshot.ref.getDownloadURL().then((url) {
        techImageUrl = url;
      });
    } else {
      print("No image selected");
    }

    Map<String, dynamic> techCategoryMap = {
      "techCategory": selectedCategoryType,
      "techPicture": techImageUrl,
      "rating": 0.0,
      "serviceFee": 0,
    };

    FirebaseFirestore.instance
        .collection("Technician")
        .doc(currentFirebaseUser!.uid)
        .update(techCategoryMap);

    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!
        .setString("category", selectedCategoryType.toString());
    await sharedPreferences!.setString("pic", techImageUrl);
    await sharedPreferences!.setDouble("rating", 0.0);

    Fluttertoast.showToast(msg: "Registration request sent to admin");
    fAuth.signOut();
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
                      // const Text(
                      //   'Select Category',
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //     fontSize: 20.0,
                      //     color: Color(0xFF7B4067),
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white,
                        ),
                        child: DropdownButton(
                          icon: Icon(
                            Icons.arrow_drop_down_rounded,
                            color: Color(0xFFEF8A56),
                          ),
                          underline: SizedBox(),
                          borderRadius: BorderRadius.circular(20),
                          alignment: AlignmentDirectional.center,
                          iconSize: 42,
                          items: categoryType.map((category) {
                            return DropdownMenuItem(
                              child: Text(
                                category,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 15),
                              ),
                              value: category,
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedCategoryType = newValue.toString();
                            });
                          },
                          value: selectedCategoryType,
                          hint: const Text(
                            "Please Choose Category",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      SizedBox(
                        height: 55,
                        child: LogRegSubmitBtn(
                          label: 'Sign up',
                          press: () {
                            if (selectedCategoryType != null) {
                              saveCategoryInfo();
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Please choose your category.");
                            }
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
