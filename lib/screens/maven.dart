import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/CourseController.dart';
import 'package:flutter_application_1/controllers/enrolledController.dart';
import 'package:flutter_application_1/controllers/noticationController.dart';
import 'package:flutter_application_1/screens/auth/login.dart';
import 'package:flutter_application_1/screens/root_app.dart';
import 'package:flutter_application_1/screens/welcome_page.dart';
import 'package:flutter_application_1/theme/color.dart';
import 'package:flutter_application_1/utils/data.dart';
import 'package:get/get.dart';
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

  Future _checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

    // Add a delay using Future.delayed
    Future.delayed(Duration(seconds: 5), () async {
      if (isFirstTime) {
        // If it's the first time, navigate to the introduction page
        await prefs.setBool('isFirstTime', false);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => welcome_page(),
          ),
        );
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
          String uid = FirebaseAuth.instance.currentUser!.uid;
          await _notificationController.loadAllNotification(uid);
          await _enrollController.loadAllCourse(uid);
          var username = await FirebaseFirestore.instance
          .collection("User")
          .where("id", isEqualTo: uid)
          .get();
          profile['name'] = username.docs[0].data()['name'];
          profile['email'] = username.docs[0].data()['email'];
          profile['img'] = username.docs[0].data()['img'];
          profile['point'] = username.docs[0].data()['point'];
          profile['money'] = username.docs[0].data()['money'];
          
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            Image.asset(
                "assets/images/1.png",
                                width: 100,
                                height: 100,
                                color: AppColor.primary,
                              ),
          is_loading ?
          SizedBox(height: MediaQuery.of(context).size.height / 8,)
          : SizedBox(),
          is_loading ?
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(const Color.fromARGB(255, 149, 149, 149)),
            )
          : SizedBox(height: 0,),
        ],
      ),
    ),
  );
}