import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/enrolledController.dart';
import 'package:flutter_application_1/model/courseModel.dart';
import 'package:flutter_application_1/model/enrollModel.dart';
import 'package:flutter_application_1/screens/root_app.dart';

import 'package:flutter_application_1/theme/color.dart';
import 'package:flutter_application_1/utils/data.dart';
import 'package:flutter_application_1/widgets/bookmark_box.dart';
import 'package:flutter_application_1/widgets/custom_image.dart';
import 'package:flutter_application_1/widgets/excercise_item.dart';
import 'package:flutter_application_1/widgets/lesson_item.dart';
import 'package:readmore/readmore.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';


class CourseDetailPage extends StatefulWidget {
  CourseDetailPage({Key? key, required this.data}) : super(key: key) {
    _enrollController = Get.find<enrolledController>();
  }
  final data;
  var _enrollController;
  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late var courseData;
  bool paymentOngoing = false;
  List<enrollModel> _enrollCourse = [];
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    List<enrollModel> allcouse = List.from(widget._enrollController.allCourse);
    _enrollCourse = List.from(
      allcouse.where((element) => element.toJSON()['course_id'] == widget.data['course']['id']));
    courseData = widget.data["course"];
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(),
      body: buildBody(),
      bottomNavigationBar: getFooter(),
    );
  }

  AppBar buildAppbar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: Padding(
        padding: EdgeInsets.only(left: 0),
        child: Center(
          child: Text(
            "Detail",
            style: TextStyle(color: AppColor.textColor),
          ),
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

  Widget buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
      child: Column(children: [
        Hero(
          tag: courseData["id"].toString() + courseData["img"] ,
          child: CustomImage(
            courseData["img"],
            radius: 10,
            width: double.infinity,
            height: 200,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        getInfo(),
        SizedBox(
          height: 10,
        ),
        Divider(),
        getTabBar(),
        getTabbarPages(),
      ]),
    );
  }

  Widget getTabBar() {
    return Container(
      child: TabBar(
          indicatorColor: AppColor.primary,
          controller: tabController,
          tabs: [
            Tab(
              child: Text(
                "Lessons",
                style: TextStyle(fontSize: 16, color: AppColor.textColor),
              ),
            ),
            Tab(
              child: Text(
                "Exercices",
                style: TextStyle(fontSize: 16, color: AppColor.textColor),
              ),
            )
          ]),
    );
  }

  Widget getTabbarPages() {
    return Container(
      height: 200,
      width: double.infinity,
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: [
          getLessons(),
          getExcercise(),
        ],
      ),
    );
  }

  Widget getLessons() {
    return ListView.builder(
        itemCount: courseData['videos'].length,
        itemBuilder: (context, index) => LessonItem(
              data: {"video" :courseData['videos'][index], "course": widget.data['course']},
              enrolled: _enrollCourse.length != 0,
              complete: _enrollCourse.length == 0 ? false : index < _enrollCourse[0].video_seen.length,
              ongoing: _enrollCourse.length == 0 ? false : index == _enrollCourse[0].video_seen.length,
              onVideoComplete: (isComplete) {
                        setState(() {
                          if(isComplete) {
                            index;
                          }
                        });
              },
            ));
  }

   Widget getExcercise() {
    return ListView.builder(
        itemCount: courseData['quizzes'].length,
        itemBuilder: (context, index) => excerciseItem(
              data: {"quiz" :courseData['quizzes'][index], "course": widget.data['course']},
              enrolled: _enrollCourse.length != 0,
              complete: _enrollCourse.length == 0 ? false : index < _enrollCourse[0].quiz_complete.length,
              ongoing: _enrollCourse.length == 0 ? false : index == _enrollCourse[0].quiz_complete.length,
            ));
  }

  Widget getInfo() {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              courseData["title"],
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: AppColor.textColor),
            ),
            BookmarkBox(
              isBookmarked: false,
              onTap: () {
                // setState(() {
                //    courseData["is_favorited"] = ! courseData["is_favorited"]; 
                // });
              },
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            getAttribute(Icons.play_circle_outline, "${courseData["videos"].length} videos",
                AppColor.labelColor),
            SizedBox(
              width: 20,
            ),
            getAttribute(Icons.quiz_outlined, "${courseData["quizzes"].length} quiz",
                AppColor.labelColor),
            SizedBox(
              width: 20,
            ),
            getAttribute(Icons.star, courseData["rating"].toString(), Colors.yellow),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "About Course",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColor.textColor,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ReadMoreText(
              courseData["description"],
              trimMode: TrimMode.Line,
              trimLines: 2,
              style: TextStyle(fontSize: 14, color: AppColor.labelColor),
              trimCollapsedText: "Show more",
              trimExpandedText: " Show less",
              moreStyle: TextStyle(
                  fontSize: 14,
                  color: AppColor.primary,
                  fontWeight: FontWeight.w500),
              lessStyle: TextStyle(
                  fontSize: 14,
                  color: AppColor.primary,
                  fontWeight: FontWeight.w500),
            ),
          ],
        )
      ]),
    );
  }

  Widget getAttribute(IconData icon, String info, Color color) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: color,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          info,
          style: TextStyle(color: AppColor.labelColor),
        ),
      ],
    );
  }

  Widget getFooter() {
    return Container(
      width: double.infinity,
      height: 80,
      padding: EdgeInsets.fromLTRB(15, 0, 15, 20),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: AppColor.shadowColor.withOpacity(.05),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 0))
      ]),
      // checking which mood to view course
      child: _enrollCourse.length == 0 ?
        Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${courseData["payment"] + (courseData["payment"] * 0.1)} BDT",
              style: TextStyle(
                  fontSize: 14,
                  color: AppColor.labelColor,
                  decoration: TextDecoration.lineThrough,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              "${courseData["payment"]} BDT",
              style: TextStyle(
                  fontSize: 20,
                  color: AppColor.textColor,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Expanded(
          child:
              Container(), // This is an empty container to fill the available space
        ),
        // Button added to the bottom right
        paymentOngoing ?
        Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(AppColor.primary),
        ),)
        : ElevatedButton(
          onPressed: () async {
            setState(() {
              paymentOngoing = true;
            });
            num currentBalance = profile['money'] as num;
            if(currentBalance >= courseData["payment"]) {
              if(await update(currentBalance - courseData["payment"])) {}
              print("Payment done!");
              setState(() {
                paymentOngoing = false;
                List<enrollModel> allcouse = List.from(Get.find<enrolledController>().allCourse);
                _enrollCourse = List.from(
                  allcouse.where((element) => element.toJSON()['course_id'] == widget.data['course']['id']));
                // _enrollCourse.length;
                profile['money'] = currentBalance - courseData["payment"];
              });
              // Navigator.pushReplacement(context, MaterialPageRoute(
              //     builder: (context) =>
              //         CourseDetailPage(data: {"course": courseData})));
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) =>
              //         EnrolledCourseDetail(data: {"course": courseData})));
            }
            else {
              _showMessage(context, "Not enough balance in your account!", true, "Error!");
            }
            setState(() {
              paymentOngoing = false;
            });
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(AppColor.primary),
              minimumSize: MaterialStateProperty.all(Size(275, 40)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)))),
          child: Text(
            "Buy Now",
            style: TextStyle(),
          ),
        ),
      ])
      // For user who already enrolled this course
      : Row(crossAxisAlignment: CrossAxisAlignment.center, children:[
          // Expanded(
          //   child: Text(
          //     "Press Complete to end the course!"
          //   ),
          // ),
          // Expanded(
          //   child:
          //       Container(), // This is an empty container to fill the available space
          // ),
          paymentOngoing ?
          Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(AppColor.primary),
          ),)
          : ElevatedButton(
            onPressed: () async {
              setState(() {
                paymentOngoing = true;
              });
              // check all quiz done and video watched
              if(_enrollCourse[0].quiz_complete.length == courseData['quizzes'].length && _enrollCourse[0].video_seen.length == courseData['videos'].length) {
                if(await completeUpdate()) {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) =>
                            RootApp()),
                      );
                }
              }
              else {
                _showMessage(context, "Complete all video and quiz!", true, "Error!");
              }
              setState(() {
                paymentOngoing = false;
              });
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColor.primary),
                minimumSize: MaterialStateProperty.all(Size(275, 40)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)))),
            child: Text(
              "Complete",
              style: TextStyle(),
            ),
          ),
        ]),
      );
  }

  Future<bool> update(num value) {
    Future<bool> temp = Get.find<enrolledController>().updateInfo(FirebaseAuth.instance.currentUser!.uid, courseData['id'], value);
    return temp;
  }

  Future<bool> completeUpdate() {
    Future<bool> temp = Get.find<enrolledController>().remove(FirebaseAuth.instance.currentUser!.uid, courseData['id']);
    return temp;
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
              child: Text('Ok'),
              style: ElevatedButton.styleFrom(
                backgroundColor: _error ? AppColor.red : AppColor.green,
              ),
            ),
          ],
        );
      },
    );
  }

}
