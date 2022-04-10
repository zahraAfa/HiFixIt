import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hifixit/app/modules/customer/modules/authentication/views/login_screen.dart';
import 'package:hifixit/app/modules/customer/modules/authentication/widgets/log_reg_submit_btn.dart';
import 'package:hifixit/app/modules/customer/modules/authentication/widgets/log_reg_switch_btn.dart';
import 'package:hifixit/services/global.dart';
import 'package:hifixit/app/modules/splashScreen/splash_screen.dart';
import 'package:hifixit/widgets/progress_dialog.dart';
import 'user_input_log_reg.dart';

class SignupFormBody extends StatelessWidget {
  const SignupFormBody({
    Key? key,
    required this.pageType,
    required this.message,
  }) : super(key: key);

  final String pageType;
  final String message;

  @override
  Widget build(BuildContext context) {
    String _emailInput = "";
    String _passwordInput = "";
    String _fNameInput = "";
    String _lNameInput = "";
    String _phoneInput = "";

    saveCustInfoNow() async {
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
        email: _emailInput.trim(),
        password: _passwordInput.trim(),
      )
              .catchError((msg) {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "Error: " + msg.toString());
      }))
          .user;

      if (firebaseUser != null) {
        Map custMap = {
          "custId": firebaseUser.uid,
          "custFName": _fNameInput.trim(),
          "custLName": _lNameInput.trim(),
          "custEmail": _emailInput.trim(),
          "custPhone": _phoneInput.trim(),
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

    validateForm() {
      Fluttertoast.showToast(msg: "All field must be filled.");
    }

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
                // height: 510,
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
                      Text(
                        pageType,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20.0,
                          color: Color(0xFF7B4067),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 25),
                      UserInputLogReg(
                        hintTitle: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        onChanged: (value) {
                          _emailInput = value;
                        },
                      ),
                      UserInputLogReg(
                        hintTitle: 'First Name',
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        onChanged: (value) {
                          _fNameInput = value;
                        },
                      ),
                      UserInputLogReg(
                        hintTitle: 'Last Name',
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        onChanged: (value) {
                          _lNameInput = value;
                        },
                      ),
                      UserInputLogReg(
                        hintTitle: 'Phone Number',
                        keyboardType: TextInputType.phone,
                        obscureText: false,
                        onChanged: (value) {
                          _phoneInput = value;
                        },
                      ),
                      UserInputLogReg(
                        hintTitle: 'Password',
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        onChanged: (value) {
                          _passwordInput = value;
                        },
                      ),
                      SizedBox(
                        height: 35,
                        child: LogRegSubmitBtn(
                          label: pageType == 'Sign up' ? 'Next' : 'Sign up',
                          press: () {
                            if ((_emailInput.isNotEmpty) &&
                                (_fNameInput.isNotEmpty) &&
                                (_lNameInput.isNotEmpty) &&
                                (_phoneInput.isNotEmpty) &&
                                (_passwordInput.isNotEmpty)) {
                              saveCustInfoNow();
                            } else {
                              validateForm();
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      // const Center(
                      //   child: Text('Forgot password ?'),
                      // ),
                      const SizedBox(height: 50),
                      const Divider(thickness: 0, color: Colors.white),
                      LogRegSwitchBtn(
                          btnTitle:
                              pageType == 'Sign in' ? 'Sign up' : 'Sign in',
                          message: message,
                          nav: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (c) => const LoginScreenCust()));
                          }),
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

  inputTextValue(value) {}
}
