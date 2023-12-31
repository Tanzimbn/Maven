import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/screens/addCourse.dart';
import 'package:flutter_application_1/page/home_page.dart';
import 'package:flutter_application_1/screens/auth/login.dart';
import 'firebase_options.dart';
import 'package:flutter_application_1/screens/welcome_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyASwlktOkXDTZOtTe3YuU3GHVg7spYH7h8",
      appId: "1:587480634133:web:3317c4cae0f1e218a50f1c",
      messagingSenderId: "587480634133",
      projectId: "login-signup-94458",
      authDomain: 'login-signup-94458.firebaseapp.com',
      databaseURL: 'https://login-signup-94458-default-rtdb.firebaseio.com/',
      storageBucket: 'login-signup-94458.appspot.com',
    ));
  } else {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Maven',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LogIn(),
    );
  }
}
