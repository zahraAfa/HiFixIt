import 'package:firebase_auth/firebase_auth.dart';
import 'package:hifixit/app/models/Customer.dart';

final FirebaseAuth fAuth = FirebaseAuth.instance;
User? currentFirebaseUser;
Customer? custModelCurrentInfo;
