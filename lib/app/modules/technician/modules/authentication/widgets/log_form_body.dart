import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hifixit/app/modules/technician/modules/authentication/controllers/tech_login_controller.dart';
import 'package:hifixit/app/modules/technician/modules/authentication/views/signup_screen.dart';
import 'package:hifixit/app/modules/technician/modules/authentication/widgets/log_reg_submit_btn.dart';
import 'package:hifixit/app/modules/technician/modules/authentication/widgets/log_reg_switch_btn.dart';
import 'user_input_log_reg.dart';

class LoginFormBody extends StatefulWidget {
  const LoginFormBody({
    Key? key,
    required this.pageType,
    required this.message,
  }) : super(key: key);

  final String pageType;
  final String message;

  @override
  State<LoginFormBody> createState() => _LoginFormBodyState();
}

class _LoginFormBodyState extends State<LoginFormBody> {
  @override
  Widget build(BuildContext context) {
    String _emailInput = "";
    String _passwordInput = "";

    validateForm() {
      Fluttertoast.showToast(msg: "All field must be filled.");
      setState(() {
        _emailInput = _emailInput;
        _passwordInput = _passwordInput;
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
                          label: widget.pageType == 'Sign in'
                              ? 'Sign in'
                              : 'Sign up',
                          press: () {
                            if ((_emailInput.isNotEmpty) &&
                                (_passwordInput.isNotEmpty)) {
                              loginTechNow(
                                  passwordInput: _passwordInput,
                                  emailInput: _emailInput,
                                  context: context);
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
                                    builder: (c) => const SignUpScreenTech()));
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
