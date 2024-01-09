import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/controllers/CourseController.dart';
import 'package:flutter_application_1/controllers/enrolledController.dart';
import 'package:flutter_application_1/screens/addCourse.dart';
import 'package:flutter_application_1/screens/auth/forgotpassword.dart';
import 'package:flutter_application_1/screens/auth/signup.dart';
import 'package:flutter_application_1/page/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/root_app.dart';
import 'package:flutter_application_1/theme/color.dart';
import 'package:flutter_application_1/utils/data.dart';
import 'package:get/get.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String email = "tanzimbinnasir@gmail.com", password = "tanzim10";
  var _courseController = Get.put(courseController());
  var _enrollController = Get.put(enrolledController());
  bool _loading = false;

  final _formkey = GlobalKey<FormState>();

  TextEditingController useremailcontroller = new TextEditingController();
  TextEditingController userpasswordcontroller = new TextEditingController();

  userLogin() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      FirebaseFirestore _firestore = FirebaseFirestore.instance;
      var username = await _firestore
          .collection("User")
          .where("id", isEqualTo: userCredential.user?.uid)
          .get();
      profile['name'] = username.docs[0].data()['name'];
      profile['email'] = username.docs[0].data()['email'];
      profile['img'] = username.docs[0].data()['img'];
      profile['point'] = username.docs[0].data()['point'];
      profile['money'] = username.docs[0].data()['money'];
      print("------------singin ok --------------------");
      await _courseController.loadAllCourse();
      await _enrollController.loadAllCourse(userCredential.user!.uid);
      print("--------------dataload--------------------");
      setState(() {
        _loading = false;
      });
      Navigator.push(context, MaterialPageRoute(builder: (context) => RootApp()));

    } on FirebaseAuthException catch (e) {
      print(e.code);
      setState(() {
        _loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          "Invalid Email or Password",
          style: TextStyle(
              fontSize: 18.0, color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBgColor,
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50.0,
                ),
                Center(
                  child: Image.asset(
                    "assets/images/1.png",
                    width: 200,
                    height: 200,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: Center(
                    child: Text(
                      "Welcome back!",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 3.0),
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 0, 0, 0),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    controller: useremailcontroller,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '  Please Enter E-Mail';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        errorStyle:
                            TextStyle(color: Color.fromARGB(255, 255, 2, 2)),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.white,
                        ),
                        hintText: 'Your Email',
                        hintStyle: TextStyle(color: Colors.white60)),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 3.0),
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 0, 0, 0),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    controller: userpasswordcontroller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '  Please Enter Password';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.key,
                          color: Colors.white,
                        ),
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.white60)),
                    style: TextStyle(color: Colors.white),
                    obscureText: true,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPassword()));
                  },
                  child: Container(
                    padding: EdgeInsets.only(right: 24.0),
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontSize: 18.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                _loading ? Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(AppColor.primary),
                  ),
                )
                : GestureDetector(
                  onTap: () {
                    setState(() {
                        _loading = true;
                    });
                    // if (_formkey.currentState!.validate()) {
                      setState(() {
                        // email = useremailcontroller.text;
                        // password = userpasswordcontroller.text;
                      });
                      userLogin();
                    // }
                  },
                  child: Center(
                    child: Container(
                      width: 150,
                      height: 55,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: AppColor.secondary,
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                          child: Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "New User?",
                      style: TextStyle(
                          color: const Color.fromARGB(255, 21, 20, 20),
                          fontSize: 20.0),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()));
                        },
                        child: Text(
                          " Signup",
                          style: TextStyle(
                              color: Color.fromARGB(255, 250, 36, 54),
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
                SizedBox(
                  height: 40.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
