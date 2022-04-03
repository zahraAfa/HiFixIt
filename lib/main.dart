import 'package:flutter/material.dart';
import 'package:hifixit/technician/pages/cust/login.dart';
import 'package:hifixit/technician/pages/cust/regist.dart';
import 'package:hifixit/technician/pages/welcome.dart';
import 'package:hifixit/technician/splashScreen/splash_screen.dart';
import 'package:hifixit/route_generator.dart';
import 'package:hifixit/widgets/color_pallete.dart';

void main() async {
  const String appTitle = 'HiFixIt';
  WidgetsFlutterBinding.ensureInitialized();
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
        // onGenerateRoute: RouteGenerator.generateRoute,
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

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
