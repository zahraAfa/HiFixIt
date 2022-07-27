import 'package:firebase_auth/firebase_auth.dart';
import 'package:hifixit/app/models/Customer.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth fAuth = FirebaseAuth.instance;
User? currentFirebaseUser;
Customer? custModelCurrentInfo;
SharedPreferences? sharedPreferences;
