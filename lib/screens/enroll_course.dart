import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/CourseController.dart';
import 'package:flutter_application_1/controllers/enrolledController.dart';
import 'package:flutter_application_1/model/courseModel.dart';
import 'package:flutter_application_1/model/enrollModel.dart';
import 'package:flutter_application_1/theme/color.dart';
import 'package:flutter_application_1/utils/data.dart';
import 'package:flutter_application_1/widgets/course_item.dart';
import 'package:get/get.dart';

class enrollCourse extends StatefulWidget {
  var _courseController, _enrollController;

  enrollCourse({Key? key}) : super(key: key) {
    _courseController = Get.find<courseController>();
    _enrollController = Get.find<enrolledController>();
  }

  @override
  State<enrollCourse> createState() => _enrollCourse();
}

class _enrollCourse extends State<enrollCourse> {

  List<courseModel> allCourse = [], enrollCourses = [];
  List<enrollModel> enroll = [];
  List<String> enrollId = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allCourse = List.from(widget._courseController.allCourse);
    enroll = List.from(widget._enrollController.allCourse);
    for(int i = 0; i < enroll.length; i++) {
      var temp = enroll[i].toJSON();
      enrollId.add(temp['course_id']);
    }
    for(int i = 0; i < allCourse.length; i++) {
      var temp = allCourse[i].toJSON();
      if(enrollId.contains(temp['id'])) {
        enrollCourses.add(allCourse[i]);
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
      title: Padding(
        padding: EdgeInsets.only(left: 100),
        child: Text(
          "Enrolled Courses",
          style: TextStyle(color: AppColor.textColor),
        ),
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
              print(enrollCourses.length);
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) =>
              //         CourseDetailPage(data: {"course": features[index]})));
            },
            child: CourseItem(
              data: enrollCourses[index].toJSON(),
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
      childCount: enrollCourses.length,
    );
  }

}