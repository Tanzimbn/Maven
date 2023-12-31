import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/addCourse.dart';
import 'package:flutter_application_1/main.dart';

class HomePage extends StatelessWidget {
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref('POST');
  final usernamecontroller = TextEditingController();
  final userEmailcontroller = TextEditingController();

  void addCourse() {
    String name = usernamecontroller.text.trim();
    String email = userEmailcontroller.text.trim();
    userEmailcontroller.clear();
    usernamecontroller.clear();
    if (name != "" && email != "") {
      Map<String, dynamic> user = {
        "name": name,
        "email": email,
      };
      FirebaseFirestore.instance.collection("Course").add(user);
    } else {
      print("Error");
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('MAVEN'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'HomePage',
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CreateCourse()));
                },
                child: Text("Add course"),
              ),
              TextFormField(
                controller: usernamecontroller,
                decoration: InputDecoration(
                    // border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.password,
                      color: Colors.white,
                    ),
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.white60)),
                style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                // obscureText: true,
              ),
              TextFormField(
                controller: userEmailcontroller,
                decoration: InputDecoration(
                    // border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.password,
                      color: Colors.white,
                    ),
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.white60)),
                style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                // obscureText: true,
              ),
              GestureDetector(
                onTap: () {
                  addCourse();
                },
                child: Text("Add data"),
              ),
              // StreamBuilder(
              //   stream: FirebaseFirestore.instance.collection("Course").snapshots(), 
              //   builder: (context, snapshot) {

              //     if(snapshot.connectionState == ConnectionState.active) {
              //       if(snapshot.hasData && snapshot.data != null) {
              //         return Expanded(
              //           child: ListView.builder(
              //             itemCount: snapshot.data!.docs.length,
              //             itemBuilder: (context, index) {
              //               Map<String, dynamic> userMap = 
              //               snapshot.data!.docs[index].data() as Map<String, dynamic>;
                      
              //               return ListTile(
              //                 title: Text(userMap["name"]),
              //                 // subtitle: Text(userMap["id"].toString()),
              //                 trailing: IconButton(
              //                   icon: Icon(Icons.delete),
              //                   onPressed: () {
              //                     String id = snapshot.data!.docs[index].id;
              //                     print(snapshot.data!.docs[index].id);
              //                     FirebaseFirestore.instance.collection("Course").doc(id).delete();
              //                   },
              //                 ),
              //               );
                      
              //             },
              //           ),
              //         );
              //       }
              //       else {
              //         return Text("NO data");
              //       }
              //     }
              //     else {
              //       return Center(
              //         child: CircularProgressIndicator(),
              //       );
              //     }

              //   },
              // ),
              ListTile(
                title: Text("hello"),
              )
            ],
          ),
        ),
      );
}
