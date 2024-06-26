import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/CourseController.dart';
import 'package:flutter_application_1/model/courseModel.dart';
import 'package:flutter_application_1/screens/course_detail.dart';
import 'package:flutter_application_1/theme/color.dart';
import 'package:flutter_application_1/utils/data.dart';
import 'package:flutter_application_1/widgets/course_item.dart';
import 'package:get/get.dart';

class myCourse extends StatefulWidget {

  myCourse({Key? key}) : super(key: key) {}

  @override
  State<myCourse> createState() => _myCourse();
}

class _myCourse extends State<myCourse> {

  List<courseModel> allCourse = [], myCourses = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allCourse = List.from(Get.find<courseController>().allCourse);
    for(int i = 0; i < allCourse.length; i++) {
      var temp = allCourse[i].toJSON();
      if(temp['instructor'] == FirebaseAuth.instance.currentUser?.uid) {
        myCourses.add(allCourse[i]);
      }
    }
  }
  

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: buildAppbar(),
      body: CustomScrollView(
        slivers: [
          // SliverAppBar(
          //   backgroundColor: AppColor.appBarColor,
          //   pinned: true,
          //   title: getAppBar(),
          // ),
          SliverList(delegate: getCourses()),
        ], 
      ),
    );
  }

  AppBar buildAppbar() {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text(
          "My Courses",
          style: TextStyle(color: AppColor.textColor, fontFamily: 'Oswald'),
        ),
      iconTheme: IconThemeData(color: AppColor.textColor),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  getCourses() {

    return SliverChildBuilderDelegate(
      (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 15, left: 35, right: 35, bottom: 10),
          child: GestureDetector(
            onTap: () {
              print(myCourses.length);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      CourseDetailPage(data: {"course": myCourses[index].toJSON()})));
            },
            child: CourseItem(
              data: myCourses[index].toJSON(),
              onBookmark: () {
                setState(() {
                  // courses[index]["is_favorited"] =
                  //     !courses[index]["is_favorited"];
                });
              },
            ),
          ),
        );
      },
      childCount: myCourses.length,
    );
  }

}