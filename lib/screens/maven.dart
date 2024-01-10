import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/CourseController.dart';
import 'package:flutter_application_1/controllers/enrolledController.dart';
import 'package:flutter_application_1/controllers/noticationController.dart';
import 'package:flutter_application_1/firebase/splashService.dart';
import 'package:flutter_application_1/screens/auth/login.dart';
import 'package:flutter_application_1/screens/root_app.dart';
import 'package:flutter_application_1/screens/welcome_page.dart';
import 'package:flutter_application_1/theme/color.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_application_1/page/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class maven_splash extends StatefulWidget {
  const maven_splash({Key? key}) : super(key:key);
  @override
  State<maven_splash> createState() => _maven_splash();
}

class _maven_splash extends State<maven_splash> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool is_loading = false;
  void initState() {
    super.initState();
    _checkFirstTime();
    // Future.delayed(Duration(seconds: 5), () {
    //   // Navigate to the homepage after 3 seconds
    //   Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(
    //       builder: (context) => welcome_page(),
    //     ),
    //   );
    // });
  }

  _checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

    // Add a delay using Future.delayed
    Future.delayed(Duration(seconds: 5), () async {
      if (isFirstTime) {
        // If it's the first time, navigate to the introduction page
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => welcome_page(),
          ),
        );
        prefs.setBool('isFirstTime', false);
      } 
      else {
        User? user = _auth.currentUser;
        if (user != null) {
        // If the user is already logged in, navigate to the homepage
        setState(() {
          is_loading = true;
        });
          var _courseController = Get.put(courseController());
          var _enrollController = Get.put(enrolledController());
          var _notificationController = Get.put(notificationController());
          await _courseController.loadAllCourse();
          await _notificationController.loadAllNotification(FirebaseAuth.instance.currentUser!.uid);
          await _enrollController.loadAllCourse(FirebaseAuth.instance.currentUser!.uid);
          setState(() {
            is_loading = false;
          });
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => RootApp(),
            ),
          );
        } 
        else {
          // If not logged in, navigate to the login page
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => LogIn(),
            ),
          );
        }
    }}
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: is_loading ?
      CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(AppColor.primary),
      )
      : Image.asset(
                          "assets/images/1.png",
                          width: 100,
                          height: 100,
                          color: AppColor.primary,
                        ),
      ),
  );
}