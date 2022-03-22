import 'package:flutter/material.dart';
import 'package:hifixit/widgets/headerLoginRegist.dart';

class CustLogin extends StatelessWidget {
  static const routeName = '/authentification-screen';

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  CustLogin({Key? key, this.title}) : super(key: key);
  final title;

  Widget signInWith(IconData icon) {
    return Container(
      height: 50,
      width: 115,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.withOpacity(0.4),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24),
          TextButton(
            onPressed: () {},
            child: Text('Sign in'),
          ),
        ],
      ),
    );
  }

  Widget userInput(TextEditingController userInput, String hintTitle,
      TextInputType keyboardType, bool obscureText) {
    return Container(
      // color: const Color(0xFFDEDEDE),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 25.0,
          right: 25,
        ),
        child: TextField(
          obscureText: obscureText,
          controller: userInput,
          decoration: InputDecoration(
            hintText: hintTitle,
            hintStyle: const TextStyle(
              fontSize: 18,
              color: Colors.grey,
              fontStyle: FontStyle.italic,
            ),
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double _fullHeigh = MediaQuery.of(context).size.height;
    double _fullWidht = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: _fullWidht,
            height: _fullHeigh,
            color: const Color(0xFFF2F2F2),
          ),
          HeaderLoginRegist(
            title: title,
            thirdMessage: 'please Sign in',
          ),
          DraggableScrollableSheet(
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
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 45),
                            userInput(emailController, 'Email',
                                TextInputType.emailAddress, false),
                            userInput(passwordController, 'Password',
                                TextInputType.text, true),
                            SizedBox(
                              height: 55,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color(0xFFBF84B1)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  )),
                                ),
                                onPressed: () {
                                  print(emailController);
                                  print(passwordController);
                                },
                                child: const Text(
                                  'Sign in',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Center(
                              child: Text('Forgot password ?'),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.only(top: 25.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  signInWith(Icons.add),
                                  signInWith(Icons.book_online),
                                ],
                              ),
                            ),
                            const Divider(thickness: 0, color: Colors.white),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Don\'t have an account yet ? ',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontStyle: FontStyle.italic),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
