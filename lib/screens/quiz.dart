import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/enrolledController.dart';
import 'package:flutter_application_1/screens/course_detail.dart';
import 'package:flutter_application_1/theme/color.dart';
import 'package:flutter_application_1/utils/data.dart';
import 'package:get/get.dart';

class QuizPage extends StatefulWidget {
  QuizPage({Key? key, required this.data}) : super(key: key);
  final data;
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  String question = "";
  List<String> options = [];
  num point = 0;
  num selectedOption = -1;
  String answer = "0"; // Initialize with an empty string
  bool submitted = false;

  void initState() {
    question = widget.data['quiz']['question'];
    options.add(widget.data['quiz']['op1']); options.add(widget.data['quiz']['op2']); options.add(widget.data['quiz']['op3']); options.add(widget.data['quiz']['op4']);
    point = widget.data['quiz']['point'];
    answer = widget.data['quiz']['answer'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      appBar: buildAppbar(),
      body: Container(
        // borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
            color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 25.0, 16.0, 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Question :",
                style: TextStyle(
                  color: AppColor.secondary,
                ),
              ),
              SizedBox(height: 5,),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 214, 211, 211),
                  borderRadius:BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    // Icon(Icons.question_mark, color: AppColor.primary,),
                    Expanded(
                      child: Text(
                        question,
                        style: TextStyle(fontSize: 18, color: const Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Options :",
                style: TextStyle(
                  color: AppColor.secondary,
                ),
              ),
              SizedBox(height: 5,),
              Expanded(
                child: ListView.builder(
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedOption = index;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10),
                          color: selectedOption == index
                              ? const Color.fromARGB(255, 250, 249, 249)
                              : AppColor.primary,
                        ),
                        child: Expanded(
                          child: Text(
                            options[index],
                            style: TextStyle(
                              color: selectedOption == index
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              submitted ?
              Center(
                child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(AppColor.primary),
                ),
              )
              : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      // Handle submit button click
                      setState(() {
                        submitted = true;
                      });
                      print(selectedOption);
                      if((selectedOption + 1).toString() == answer) {
                        await updateProfile(FirebaseAuth.instance.currentUser!.uid, point);
                        await _showMessage(context, "Congratulations! you get ${point} coin${point > 1? 's':''}", false, "Correct answer!");
                        await Get.find<enrolledController>().updateResource(FirebaseAuth.instance.currentUser!.uid, widget.data['course']['id'], false);
                      //  Navigator.of(context).pop();
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) =>
                              CourseDetailPage(data: {"course": widget.data['course']})),
                        );  
                      }
                      else {
                        await _showMessage(context, "Wrong answer", true, "Oops!");
                      }
                      setState(() {
                        submitted = false;
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(AppColor.primary),
                      minimumSize: MaterialStateProperty.all(Size(150, 40)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)))),
                    child: Text('Submit',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle cancel button click
                    },
                    style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(AppColor.primary),
                    minimumSize: MaterialStateProperty.all(Size(150, 40)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)))),
                    child: Text('Cancel',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppbar() {
    return AppBar(
      backgroundColor: AppColor.primary,
      toolbarHeight: 100,
      centerTitle: true,
      title: Text(
            "Quiz",
            style: TextStyle(color: AppColor.appBgColor),
      ),
      iconTheme: IconThemeData(color: AppColor.appBgColor),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
        ),
        onPressed: () {
          // Navigator.pop(context);
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) =>
              CourseDetailPage(data: {"course": widget.data['course']})),
          );  
        },
      ),
    );
  }

  Future<void> _showMessage(BuildContext context, String mess, bool _error, String title) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColor.textColor,
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          content: Text(mess),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Ok',
                style: TextStyle(
                        color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: _error ? AppColor.red : AppColor.green,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<bool> updateProfile(String uid, num value) async {
    num val = profile['point'] as num;
    profile['point'] = point + val;
    print('${profile['point']}');

    num cur = profile['money'] as num;
    profile['money'] = cur + point;

    final post =  await FirebaseFirestore.instance.collection("User")
    .where('id', isEqualTo: uid).get()
    .then((QuerySnapshot snapshot) {
          //Here we get the document reference and return to the post variable.
          return snapshot.docs[0].reference;
    });
    var batch = FirebaseFirestore.instance.batch();
    //Updates the field value, using post as document reference
    batch.update(post, { 'point': point + value, 'money' : cur + value }); 
    batch.commit();
    return true;
  }

}
