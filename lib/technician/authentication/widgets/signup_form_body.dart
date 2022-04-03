import 'package:flutter/material.dart';
import 'package:hifixit/technician/authentication/category_info_screen.dart';
import 'package:hifixit/technician/authentication/login_screen.dart';
import 'package:hifixit/technician/authentication/signup_screen.dart';
import 'package:hifixit/widgets/auth/log_reg_submit_btn.dart';
import 'package:hifixit/widgets/auth/log_reg_switch_btn.dart';
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
                        hintTitle: 'Name',
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        onChanged: (value) {
                          _emailInput = value;
                        },
                      ),
                      UserInputLogReg(
                        hintTitle: 'Phone Number',
                        keyboardType: TextInputType.phone,
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
                          label: pageType == 'Sign up' ? 'Next' : 'Sign up',
                          press: () {
                            print(_emailInput);
                            print(_passwordInput);
                            // Navigator.of(context).pushNamed('/cust-account',
                            //     arguments: 'Account');
                            Navigator.push(
                                // context, MaterialPageRoute(builder: (c) => MainScreenTech()));
                                context,
                                MaterialPageRoute(
                                    builder: (c) =>
                                        const CategoryInfoRegistScreen()));
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
                                    builder: (c) => const LoginScreenTech()));
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
