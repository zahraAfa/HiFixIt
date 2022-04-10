import 'package:flutter/material.dart';
import 'package:hifixit/route_generator.dart';
import 'package:hifixit/app/modules/splashScreen/views/splash_screen.dart';
import 'package:hifixit/app/widgets/color_pallete.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  const String appTitle = 'HiFixIt';
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MyApp(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appTitle,
        theme: ThemeData(
          primaryColor: const MaterialColor(0xFFBF84B1, primaryPurple),
          primarySwatch: const MaterialColor(0xFF3d1b3c, primaryPurple),
        ),
        home: const MySplashScreen(),
        // home: WelcomingPage(title: appTitle),
        // initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  MyApp({this.child});

  final Widget? child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_MyAppState>()!.restartApp();
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Key key = UniqueKey();
  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      child: widget.child!,
      key: key,
    );
  }
}
