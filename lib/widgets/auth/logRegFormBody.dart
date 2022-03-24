import 'package:flutter/material.dart';
import 'package:hifixit/widgets/auth/logRegSubmitBtn.dart';
import 'package:hifixit/widgets/auth/logRegSwitchBtn.dart';
import 'userInputLogReg.dart';

class LoginRegistFormBody extends StatelessWidget {
  const LoginRegistFormBody({
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
                            print(_emailInput);
                            print(_passwordInput);
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
                            if (pageType == 'Sign in') {
                              Navigator.of(context).pushReplacementNamed(
                                  '/regist',
                                  arguments: 'HiFixIt');
                            } else if (pageType == 'Sign up') {
                              Navigator.of(context).pushReplacementNamed(
                                  '/login',
                                  arguments: 'HiFixIt');
                            }
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
