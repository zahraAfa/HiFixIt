import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hifixit/app/modules/customer/modules/authentication/views/signup_screen.dart';
import 'package:hifixit/app/modules/customer/modules/authentication/widgets/log_reg_submit_btn.dart';
import 'package:hifixit/app/modules/customer/modules/authentication/widgets/log_reg_switch_btn.dart';
import 'package:hifixit/app/controllers/global.dart';
import 'package:hifixit/app/modules/splashScreen/splash_screen.dart';
import 'package:hifixit/widgets/progress_dialog.dart';
import 'user_input_log_reg.dart';

class LoginFormBody extends StatelessWidget {
  const LoginFormBody({
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

    loginCustNow() async {
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
        email: _emailInput.trim(),
        password: _passwordInput.trim(),
      )
              .catchError((msg) {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "Error: " + msg.toString());
      }))
          .user;

      if (firebaseUser != null) {
        currentFirebaseUser = firebaseUser;
        Fluttertoast.showToast(msg: "Login Successful.");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => const MySplashScreen(),
          ),
        );
      } else {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "Invalid data.");
      }
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
                        hintTitle: 'Password',
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        onChanged: (value) {
                          _passwordInput = value;
                        },
                      ),
                      SizedBox(
                        height: 55,
                        child: LogRegSubmitBtn(
                          label: pageType == 'Sign in' ? 'Sign in' : 'Sign up',
                          press: () {
                            if ((_emailInput.isNotEmpty) &&
                                (_passwordInput.isNotEmpty)) {
                              loginCustNow();
                            } else {
                              validateForm();
                            }
                          },
                        ),
                      ),
                      // const SizedBox(height: 20),
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
                                    builder: (c) => const SignUpScreenCust()));
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
