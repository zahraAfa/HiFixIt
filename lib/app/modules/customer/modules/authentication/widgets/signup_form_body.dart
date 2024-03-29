import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hifixit/app/modules/customer/modules/authentication/controllers/cust_signup_controller.dart';
import 'package:hifixit/app/modules/customer/modules/authentication/views/login_screen.dart';
import 'package:hifixit/app/modules/customer/modules/authentication/widgets/log_reg_submit_btn.dart';
import 'package:hifixit/app/modules/customer/modules/authentication/widgets/log_reg_switch_btn.dart';
import 'user_input_log_reg.dart';

class SignupFormBody extends StatefulWidget {
  const SignupFormBody({
    Key? key,
    required this.pageType,
    required this.message,
  }) : super(key: key);

  final String pageType;
  final String message;

  @override
  State<SignupFormBody> createState() => _SignupFormBodyState();
}

class _SignupFormBodyState extends State<SignupFormBody> {
  @override
  Widget build(BuildContext context) {
    String _emailInput = "";
    String _passwordInput = "";
    String _fNameInput = "";
    String _lNameInput = "";
    String _phoneInput = "";

    validateForm() {
      Fluttertoast.showToast(msg: "All field must be filled.");
      setState(() {
        _emailInput = _emailInput;
        _passwordInput = _passwordInput;
        _fNameInput = _fNameInput;
        _lNameInput = _lNameInput;
        _phoneInput = _phoneInput;
      });
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
                        widget.pageType,
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
                        height: 55,
                        child: LogRegSubmitBtn(
                          label:
                              widget.pageType == 'Sign up' ? 'Next' : 'Sign up',
                          press: () {
                            if ((_emailInput.isNotEmpty) &&
                                (_fNameInput.isNotEmpty) &&
                                (_lNameInput.isNotEmpty) &&
                                (_phoneInput.isNotEmpty) &&
                                (_passwordInput.isNotEmpty)) {
                              saveCustInfoNow(
                                  context: context,
                                  emailInput: _emailInput,
                                  passwordInput: _passwordInput,
                                  fNameInput: _fNameInput,
                                  lNameInput: _lNameInput,
                                  phoneInput: _phoneInput);
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
                      // const SizedBox(height: 50),
                      const Divider(thickness: 0, color: Colors.white),
                      LogRegSwitchBtn(
                          btnTitle: widget.pageType == 'Sign in'
                              ? 'Sign up'
                              : 'Sign in',
                          message: widget.message,
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
