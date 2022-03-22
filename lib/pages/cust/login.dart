import 'package:flutter/material.dart';
import 'package:hifixit/widgets/headerLoginRegist.dart';

class CustLogin extends StatelessWidget {
  const CustLogin({Key? key, required this.title}) : super(key: key);
  final String title;

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
            color: const Color(0xFFDEDEDE),
          ),
          HeaderLoginRegist(
            title: title,
            thirdMessage: 'please Sign in',
          ),
          SizedBox.expand(
            child: DraggableScrollableSheet(
              minChildSize: 0.7,
              maxChildSize: 0.75,
              initialChildSize: 0.7,
              builder: (context, scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Container(
                    width: _fullWidht,
                    height: _fullHeigh * 0.75,
                    color: const Color(0xFFDEDEDE),
                    child: SizedBox(
                      width: _fullWidht * 0.4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('Sign in'),
                          const SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
