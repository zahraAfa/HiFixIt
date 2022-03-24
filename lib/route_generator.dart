import 'package:flutter/material.dart';
import 'package:hifixit/main.dart';
import 'package:hifixit/pages/cust/login.dart';
import 'package:hifixit/pages/cust/regist.dart';
import 'package:hifixit/pages/welcome.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => const WelcomingPage(title: 'HiFixIt'));
      case '/login':
        return MaterialPageRoute(builder: (_) => CustLogin(title: 'title'));
      case '/regist':
        return MaterialPageRoute(
            builder: (_) => const RegistPage(title: 'title'));
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
