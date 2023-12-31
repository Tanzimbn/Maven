import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/color.dart';
import 'package:flutter_application_1/utils/data.dart';
import 'package:flutter_application_1/widgets/bookmark_box.dart';
import 'package:flutter_application_1/widgets/custom_image.dart';
import 'package:flutter_application_1/widgets/lesson_item.dart';
import 'package:readmore/readmore.dart';

class CourseDetailPage extends StatefulWidget {
  CourseDetailPage({Key? key, required this.data}) : super(key: key);
  final data;
  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late var courseData;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);

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
        padding: EdgeInsets.only(left: 100),
        child: Text(
          "Detail",
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

  Widget buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
      child: Column(children: [
        Hero(
          tag: courseData["id"].toString() + courseData["image"] ,
          child: CustomImage(
            courseData["image"],
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
          getLessons(),
        ],
      ),
    );
  }

  Widget getLessons() {
    return ListView.builder(
        itemCount: lessons.length,
        itemBuilder: (context, index) => LessonItem(
              data: courses[index],
            ));
  }

  Widget getInfo() {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              courseData["name"],
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: AppColor.textColor),
            ),
            BookmarkBox(
              isBookmarked: courseData["is_favorited"],
              onTap: () {
                setState(() {
                   courseData["is_favorited"] = ! courseData["is_favorited"]; 
                });
              },
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            getAttribute(Icons.play_circle_outline, courseData["session"],
                AppColor.labelColor),
            SizedBox(
              width: 20,
            ),
            getAttribute(Icons.schedule_outlined, courseData["duration"],
                AppColor.labelColor),
            SizedBox(
              width: 20,
            ),
            getAttribute(Icons.star, courseData["review"], Colors.yellow),
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
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              courseData["price"],
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
              courseData["discount"],
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
        ElevatedButton(
          onPressed: () {
            // Add your button's functionality here
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
      ]),
    );
  }
}
