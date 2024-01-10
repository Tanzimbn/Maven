import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/screens/auth/login.dart';
import 'package:flutter_application_1/screens/auth/signup.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/color.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String email = "";
  TextEditingController mailcontroller = new TextEditingController();
  bool is_loading = false;

    final _formkey= GlobalKey<FormState>();

  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "Password Reset Email has been sent !",
        style: TextStyle(fontSize: 18.0),
      )));
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "No user found for that email.",
          style: TextStyle(fontSize: 18.0),
        )));
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "Invalid Email.",
          style: TextStyle(fontSize: 18.0),
        )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(253, 0, 0, 0),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 50.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              SizedBox(
                height: 70.0,
              ),
              Container(
                alignment: Alignment.topCenter,
                child: Text(
                  "Password Recovery",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                "Enter your mail",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Form(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    child: ListView(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 10.0),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white70, width: 2.0),
                              borderRadius: BorderRadius.circular(30)),
                          child: TextFormField(
                            controller: mailcontroller,
                            validator: (value){
                              if(value==null || value.isEmpty){
                                return 'Please Enter Email';
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                hintText: "Email ",
                                hintStyle: TextStyle(
                                    fontSize: 18.0, color: Colors.white),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.white70,
                                  size: 30.0,
                                ),
                                border: InputBorder.none),
                          ),
                        ),
                        SizedBox(height: 40.0),
                        is_loading ?
                        Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(AppColor.primary),
                          ),
                        ) 
                        : Container(
                          // margin: EdgeInsets.only(left: 60.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    is_loading = true;
                                  });
                                  final bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(mailcontroller.text);
                                  if(_formkey.currentState!.validate() && emailValid){
                                    print("valid");
                                    setState(() {
                                      email= mailcontroller.text;
                                    });
                                    await resetPassword();
                                  }
                                  else {
                                    print("as");
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        content: Text(
                                      "Invalid Email!",
                                      style: TextStyle(fontSize: 18.0),
                                    )));
                                  }
                                  setState(() {
                                    is_loading = false;
                                  });
                                },
                                child: Container(
                                    width: 140,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 234, 17, 60),
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Center(
                                      child: Text(
                                        "Send Email",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                              ),
                              
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Go back to login? ",
                              style:
                                  TextStyle(fontSize: 18.0, color: Colors.white),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LogIn()));
                              },
                              child: Text("login",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 234, 17, 60),
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500,
                                  )),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style:
                                  TextStyle(fontSize: 18.0, color: Colors.white),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUp()));
                              },
                              child: Text("Create",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 234, 17, 60),
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500,
                                  )),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}