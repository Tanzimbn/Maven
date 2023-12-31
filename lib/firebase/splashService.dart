
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/auth/login.dart';
import 'package:flutter_application_1/page/home_page.dart';

class splashService {
  void isLogin(BuildContext context) {

    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if(user != null) {
      Timer(const Duration (seconds: 3), 
      () => Navigator.push(context, MaterialPageRoute(builder : (context) => HomePage()))
      );
    }
    else {
      Timer(const Duration (seconds: 3), 
      () => Navigator.push(context, MaterialPageRoute(builder : (context) => LogIn()))
      );
    }
  }
}