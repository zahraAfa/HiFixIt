import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:hifixit/app/controllers/auth_controller.dart';
import 'package:hifixit/app/routes/app_pages.dart';
import 'package:hifixit/app/utils/loading_page.dart';
import 'firebase_options.dart';
import 'package:hifixit/pages/welcome.dart';
import 'package:hifixit/route_generator.dart';
import 'package:hifixit/app/widgets/color_pallete.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final String appTitle = 'HiFixIt';

  final authCont = Get.put(AuthController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: authCont.streamAuthStatus,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: appTitle,
            theme: ThemeData(
              primaryColor: const MaterialColor(0xFFBF84B1, primaryPurple),
              primarySwatch: const MaterialColor(0xFF3d1b3c, primaryPurple),
            ),
            initialRoute: snapshot.data != null ? Routes.HOME : Routes.WELCOME,
            getPages: AppPages.routes,
          );
        }
        return const LoadingPage();
      },
    );
  }
}
