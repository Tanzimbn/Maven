import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_application_1/firebase/firebaseVideo.dart';
import 'package:flutter_application_1/model/categoryModel.dart';
import 'package:flutter_application_1/model/courseModel.dart';
import 'package:flutter_application_1/model/quizModel.dart';
import 'package:flutter_application_1/model/videoModel.dart';
import 'package:flutter_application_1/theme/color.dart';
import 'package:flutter_application_1/utils/data.dart';
import 'package:flutter_application_1/widgets/CustomTextField.dart';
import 'package:flutter_application_1/widgets/HeightSpace.dart';
import 'package:flutter_application_1/widgets/button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

class CreateCourse extends StatefulWidget {
  @override
  _CreateCoursePageState createState() => _CreateCoursePageState();
}

class _CreateCoursePageState extends State<CreateCourse> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String categoryController = "";
  TextEditingController paymentController = TextEditingController();
  TextEditingController videotitleController = TextEditingController();
  TextEditingController videoController = TextEditingController();
  TextEditingController quizTitleController = TextEditingController();
  TextEditingController quizQuestionController = TextEditingController();
  TextEditingController quizOption1Controller = TextEditingController();
  TextEditingController quizOption2Controller = TextEditingController();
  TextEditingController quizOption3Controller = TextEditingController();
  TextEditingController quizOption4Controller = TextEditingController();
  TextEditingController correctAnswerController = TextEditingController();
  TextEditingController pointsController = TextEditingController();

  List<Map<String, String>> resources = [];
  List<quizModel> quizzes = [];
  List<videoModel> videos = [];

  ImagePicker profilePicturePicker = ImagePicker();
  bool profilePictureUploaded = false;
  XFile? profilePicture;
  String userPhotoUrl = "null";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Create Course",
          style: TextStyle(color: AppColor.mainColor, fontFamily: ''),
        ),
        leading: BackButton(
          color: AppColor.mainColor,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                        child: profilePictureUploaded == false
                            ? IconButton(
                                onPressed: () async {
                                  profilePicture =
                                      await profilePicturePicker.pickImage(
                                          source: ImageSource.gallery,
                                          imageQuality: 50);
                                  if (profilePicture != null) {
                                    setState(() {
                                      profilePictureUploaded = true;
                                    });
                                  }
                                },
                                icon: const Icon(Icons.add_a_photo),
                                color: AppColor.primary,
                              )
                            .box
                            .size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height / 6)
                            .border(color: AppColor.primary, width: 2)
                            .make()
                            : ClipRRect(
                                child: Image.file(File(profilePicture!.path),
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height / 6,
                                  
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                      ),
                    height_space(),
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
                    height_space(),
                    CustomTextField(
                      title: 'Course Title',
                      hint: 'Add Course Title',
                      textController: titleController,
                    ),
                    height_space(),
                    CustomTextField(
                      title: 'Course Description',
                      hint: 'Add Course Description',
                      textController: descriptionController,
                      isBig: true,
                    ),
                    height_space(),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 226, 226, 226),
                          borderRadius: BorderRadius.circular(10)),

                      // dropdown below..
                      child: DropdownSearch<String>(
                        onChanged: (String? newValue) =>
                            setState(() => categoryController = newValue!),
                        items: categoryItem,
                        // selectedItem: categoryController,
                        popupProps: PopupProps.menu(
                          showSearchBox: true,
                          // fit: FlexFit.loose,
                          menuProps: MenuProps(
                            backgroundColor: Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          searchFieldProps: TextFieldProps(
                            decoration: InputDecoration(
                              label: Text("Search"),
                              floatingLabelStyle: const TextStyle(
                                color: AppColor.primary,
                                fontWeight: FontWeight.w500,
                              ),
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColor.primary,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              )
                            )
                          ),
                          listViewProps: ListViewProps(

                          )
                        ),
                        dropdownButtonProps: DropdownButtonProps(
                          color: AppColor.primary,
                        ),
                        dropdownDecoratorProps: DropDownDecoratorProps(
                            textAlignVertical: TextAlignVertical.center,
                            dropdownSearchDecoration: InputDecoration(
                              labelText: "Course Category",
                              labelStyle: const TextStyle(
                                color: Color.fromARGB(255, 125, 125, 125),
                                fontWeight: FontWeight.w500,
                              ),
                              floatingLabelStyle: const TextStyle(
                                color: AppColor.primary,
                                fontWeight: FontWeight.w500,
                              ),
                              hintText: "Enter Course Category",
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColor.primary,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              )
                            )
                        ),
                        validator: (String? item) {
                          if (item == null)
                            return "Required field";
                          else
                            return null;
                        },
                        
                      ),
                    ),
                    height_space(),
                    CustomTextField(
                      title: 'Payment',
                      hint: 'Add enroll amount',
                      isNumber: true,
                      textController: paymentController,
                    ),
                    height_space(),
                    Text(
                      'Course Resources',
                      style: TextStyle(
                        color: AppColor.textColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: resources.length,
                        itemBuilder: (context, index) {
                          return Card(
                              child: ListTile(
                                leading: Icon(
                                  resources[index]['type'] == 'Video'
                                      ? Icons.video_collection
                                      : Icons.question_mark,
                                  color: AppColor.primary,
                                ),
                                title: Text(
                                  '${resources[index]['type']} : ${resources[index]['title']}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                trailing: GestureDetector(
                                  child: Icon(Icons.cancel_outlined, color: AppColor.actionColor,),
                                  onTap: () {
                                    setState(() {
                                      if(resources[index]['type'] == 'Video') {
                                        videos.removeWhere((element) => element.title == resources[index]['title']);
                                      }
                                      else {
                                        quizzes.removeWhere((element) => element.title == resources[index]['title']);
                                      }
                                      resources.removeAt(index);

                                    });
                                    // resources.remove(resources[index]);
                                    print("hoise");
                                    print(resources);
                                  },
                                ),
                              ),
                              color: AppColor.textColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            );
                        }
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _showAddResourceDialog(context);
                      },
                      child: Text('Add Video or Quiz'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        _createCourse();
                      },
                      child: Text('Create Course'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAddResourceDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose resouce type'),
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColor.textColor,
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _showAddVideoDialog(context);
                },
                child: Text('Add Video'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.secondary,
                ),
              ),
              height_space(),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _showAddQuizDialog(context);
                },
                child: Text('Add Quiz'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.secondary,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showAddVideoDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Video'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextField(
                  title: "Video Title",
                  hint: "Enter Video Title",
                  textController: videotitleController,
                ),
                height_space(val: 2),
                TextButton(
                  onPressed: () async {
                    if (await _requestPermission(Permission.storage) == true) {
                      print("Permission is granted");
                    } else {
                      print("permission is not granted");
                    }
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.video,
                    );

                    if (result != null) {
                      videoController.text = result.files.single.path ?? '';
                    }
                  },
                  child: Text('Select Video from Device'),
                ),
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.secondary,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (videoController.text.isNotEmpty &&
                    videotitleController.text.isNotEmpty) {
                  setState(() {
                    videos.add(videoModel(title: videotitleController.text, url: videoController.text));
                    resources.add({
                      'type' : 'Video',
                      'title' : videotitleController.text,
                    });
                    videoController.clear();
                    videotitleController.clear();
                  });
                  Navigator.of(context).pop();
                } else {
                  // Show an error message or handle invalid input
                  _showError(context, "Give input correctly!");
                }
              },
              child: Text('Add'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.secondary,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<bool> _requestPermission(Permission permission) async {
    print("------------add--------------");
    AndroidDeviceInfo build = await DeviceInfoPlugin().androidInfo;
    print("------------add--------------");
    if (build.version.sdkInt >= 30) {
      var re = await Permission.manageExternalStorage.request();
      if (re.isGranted) {
        return true;
      } else {
        return false;
      }
    } else {
      print("------------kire--------------");
      if (await permission.isGranted) {
        return true;
      } else {
        var result = await permission.request();
        if (result.isGranted) {
          return true;
        } else {
          return false;
        }
      }
    }
  }

  Future<void> _showAddQuizDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Quiz'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextField(
                  title: "Quiz Title",
                  hint: "Enter Quiz title",
                  textController: quizTitleController,
                ),
                height_space(val: 2),
                CustomTextField(
                  title: "Question",
                  hint: "Enter quiz question",
                  isBig: true,
                  textController: quizQuestionController,
                ),
                height_space(val: 2),
                CustomTextField(
                  title: "Option - 1",
                  hint: "Enter first option",
                  textController: quizOption1Controller,
                ),
                height_space(val: 2),
                CustomTextField(
                  title: "Option - 2",
                  hint: "Enter second option",
                  textController: quizOption2Controller,
                ),
                height_space(val: 2),
                CustomTextField(
                  title: "Option - 3",
                  hint: "Enter third option",
                  textController: quizOption3Controller,
                ),
                height_space(val: 2),
                CustomTextField(
                  title: "Option - 4",
                  hint: "Enter fourth option",
                  textController: quizOption4Controller,
                ),
                height_space(val: 2),
                CustomTextField(
                  title: "Correct option",
                  hint: "Enter Correct option number",
                  isNumber: true,
                  textController: correctAnswerController,
                ),
                height_space(val: 2),
                CustomTextField(
                  title: "Rewards",
                  hint: "Enter points for correct answer",
                  isNumber: true,
                  textController: pointsController,
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.secondary,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  quizzes.add(quizModel(
                    id: DateTime.now().toString(),  
                    title: quizTitleController.text,
                    question: quizQuestionController.text,
                    op1: quizOption1Controller.text,
                    op2: quizOption2Controller.text,
                    op3: quizOption3Controller.text,
                    op4: quizOption4Controller.text,
                    answer: correctAnswerController.text,
                    point: int.parse(pointsController.text)
                  ));
                  resources.add({
                    'type' : 'quiz',
                    'title' : quizTitleController.text,
                  });
                  quizTitleController.clear();
                  quizQuestionController.clear();
                  quizOption1Controller.clear();
                  quizOption2Controller.clear();
                  quizOption3Controller.clear();
                  quizOption4Controller.clear();
                  correctAnswerController.clear();
                  pointsController.clear();
                });
                Navigator.of(context).pop();
              },
              child: Text('Add'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.secondary,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showError(BuildContext context, String mess) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error!'),
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
              child: Text('Ok'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.secondary,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _createCourse() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    for (var i = 0; i < videos.length; i++) {
      var item = videos[i].toJSON();
      print(item);
      String url = await StoreData().uploadVideo(item['url']!);
      videos[i].url = url;
    }
    String url = profilePictureUploaded ? await StoreData().uploadCoursePhoto(profilePicture!.path, "123") : "";

    courseModel course = courseModel(
      id: DateTime.now().toString(),
      title: titleController.text,
      description: descriptionController.text,
      category: categoryController,
      payment: paymentController.text,
      rating: 0,
      rating_count : 0,
      videos: videos,
      quizzes: quizzes,
      img: url,
      instructor: profile['name'],
    );
    print(course.toJSON());
    print("Course upload successfully!");
    _firestore.collection("Course").doc().set(course.toJSON());
    titleController.clear();
    descriptionController.clear();
    paymentController.clear();
    // categoryController = "";
    videos.clear();
    quizzes.clear();
    resources.clear();
    profilePictureUploaded = false;
  }
}
