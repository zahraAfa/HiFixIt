import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hifixit/app/modules/technician/modules/authentication/widgets/log_reg_submit_btn.dart';
import 'package:hifixit/app/services/global.dart';
import 'package:hifixit/app/modules/splashScreen/views/splash_screen.dart';
import 'package:image_picker/image_picker.dart';

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

  Future<void> _getImage() async {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      imageXFile;
    });
  }

  saveCategoryInfo() {
    Map techCategoryMap = {
      "category": selectedCategoryType,
    };
    DatabaseReference techRef =
        FirebaseDatabase.instance.ref().child("Technician");
    techRef
        .child(currentFirebaseUser!.uid)
        .child("TechCategory")
        .set(techCategoryMap);

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
                      DropdownButton(
                        alignment: AlignmentDirectional.center,
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 42,
                        underline: SizedBox(),
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
                      const SizedBox(height: 25),
                      SizedBox(
                        height: 55,
                        child: LogRegSubmitBtn(
                          label: 'Sign up',
                          press: () {
                            if (selectedCategoryType != null &&
                                (imageXFile == null)) {
                              saveCategoryInfo();
                            } else {
                              Fluttertoast.showToast(
                                  msg:
                                      "Please choose your category and add your photo.");
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
