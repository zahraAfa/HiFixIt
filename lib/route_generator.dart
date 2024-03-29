import 'package:flutter/material.dart';
import 'package:hifixit/app/modules/customer/modules/authentication/views/login_screen.dart';
import 'package:hifixit/app/modules/technician/modules/authentication/views/login_screen.dart';
// import 'package:hifixit/pages/cust/account.dart';
// import 'package:hifixit/pages/cust/login.dart';
// import 'package:hifixit/pages/cust/regist.dart';
import 'package:hifixit/app/modules/welcome/views/welcome.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => const WelcomingPage(title: 'HiFixIt'));

      // *************************
      //  Auth Customer Routes
      // *************************
      case '/loginCust':
        if (args is String) {
          return MaterialPageRoute(builder: (_) => const LoginScreenCust());
        }
        return _errorRoute();
      case '/loginTech':
        if (args is String) {
          return MaterialPageRoute(builder: (_) => const LoginScreenTech());
        }
        return _errorRoute();
      // case '/regist':
      //   if (args is String) {
      //     return MaterialPageRoute(builder: (_) => RegistPage(title: args));
      //   }
      //   return _errorRoute();
      // case '/cust-account':
      //   if (args is String) {
      //     return MaterialPageRoute(
      //         builder: (_) => CustAccount(
      //               pageTitle: args,
      //             ));
      //   }
      // return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
