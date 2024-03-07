import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/firebase/firebaseVideo.dart';
import 'package:flutter_application_1/model/userModel.dart';
import 'package:flutter_application_1/screens/auth/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/color.dart';
import 'package:flutter_application_1/widgets/button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email = "", password = "", name = "";
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  TextEditingController mailcontroller = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  registration() async {
    if (password != "") {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        _adduser(userCredential.user!.uid);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "Registered Successfully",
              style: TextStyle(fontSize: 20.0),
            )));
        // ignore: use_build_context_synchronously
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LogIn()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Password Provided is too Weak",
                style: TextStyle(fontSize: 18.0),
              )));
        } else if (e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Account Already exists",
                style: TextStyle(fontSize: 18.0),
              )));
        }
      }
    }
  }

  _adduser(String uid) async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    String url = profilePictureUploaded ? await StoreData().uploadUserPhoto(profilePicture!.path, uid) : "";
    userModel user = userModel(id: uid, name: namecontroller.text, email: mailcontroller.text, img: url, point: 0, money: 0);
    _firestore.collection("User").doc().set(user.toJSON());
  }
  
  ImagePicker profilePicturePicker = ImagePicker();
  bool profilePictureUploaded = false;
  XFile? profilePicture;
  String userPhotoUrl = "null";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 254, 254, 254),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 150.0, left: 20.0, right: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: profilePictureUploaded == false
                            ? IconButton(
                                onPressed: () async {
                                  profilePicture =
                                      await profilePicturePicker.pickImage(
                                          source: ImageSource.gallery,
                                          imageQuality: 50);
                                  setState(() {
                                    if (profilePicture != null)
                                    print(profilePicture!.path);
                                      profilePictureUploaded = true;
                                  });
                                },
                                icon: const Icon(Icons.add_a_photo),
                                color: AppColor.primary,
                              )
                            .box
                            .roundedFull
                            .size(100, 100)
                            .border(color: AppColor.primary, width: 2)
                            .make()
                            : CircleAvatar(
                                backgroundImage:
                                    FileImage(File(profilePicture!.path)),
                                radius:
                                    MediaQuery.of(context).size.height * 0.08,
                              ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Center(
                        child: profilePictureUploaded == true ? MyButton(
                            height: 30,
                            width: MediaQuery.of(context).size.width * 0.33,
                            name: "Remove Image",
                            whenPressed: () {
                              setState(() {
                                profilePictureUploaded = false;
                                profilePicture = null;
                              });
                        }) : 
                        SizedBox(height: 0,),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 3.0, horizontal: 5.0),
                        decoration: BoxDecoration(
                            color: AppColor.primary,
                            borderRadius: BorderRadius.circular(30)),
                        child: TextFormField(
                          controller: namecontroller,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.person_2_outlined,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                              hintText: 'Your Name',
                              hintStyle: TextStyle(color: Colors.white60)),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 3.0, horizontal: 5.0),
                        decoration: BoxDecoration(
                            color: AppColor.primary,
                            borderRadius: BorderRadius.circular(30)),
                        child: TextFormField(
                          controller: mailcontroller,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter E-mail';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: Colors.white,
                              ),
                              hintText: 'Your E-mail',
                              hintStyle: TextStyle(color: Colors.white60)),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 3.0, horizontal: 5.0),
                        decoration: BoxDecoration(
                            color: AppColor.primary,
                            borderRadius: BorderRadius.circular(30)),
                        child: TextFormField(
                          obscureText: true,
                          controller: passwordcontroller,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Password';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.password_outlined,
                                color: Colors.white,
                              ),
                              hintText: 'Password',
                              hintStyle: TextStyle(color: Colors.white60)),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (profilePictureUploaded && _formkey.currentState!.validate()) {
                            setState(() {
                              email = mailcontroller.text;
                              name = namecontroller.text;
                              password = passwordcontroller.text;
                            });
                            registration();
                          }
                          else if(profilePictureUploaded == false) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: AppColor.primary,
                            content: Text(
                              "Select your image",
                              style: TextStyle(fontSize: 18.0),
                            )));
                          }
                        },
                        child: Center(
                          child: Container(
                            width: 150,
                            height: 55,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: AppColor.primary,
                                borderRadius: BorderRadius.circular(30)),
                            child: Center(
                                child: Text(
                              "Signup",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        "Already Have Account?",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontSize: 17.0),
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => LogIn()));
                        },
                        child: Text(
                          " Login",
                          style: TextStyle(
                              color: Color.fromARGB(255, 250, 56, 56),
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
                SizedBox(
                  height: 0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
