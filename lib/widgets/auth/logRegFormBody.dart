import 'package:flutter/material.dart';
import 'package:hifixit/widgets/auth/logRegSubmitBtn.dart';
import 'package:hifixit/widgets/auth/logRegSwitchBtn.dart';
import 'userInputLogReg.dart';

class LoginRegistFormBody extends StatelessWidget {
  const LoginRegistFormBody({
    Key? key,
  }) : super(key: key);

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
                      const SizedBox(height: 45),
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
                          label: 'Sign in',
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
                      const LogRegSwitchBtn(
                        btnTitle: 'Sign up',
                        message: 'Don\'t have an account yet ? ',
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

  inputTextValue(value) {}
}
