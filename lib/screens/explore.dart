import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/CourseController.dart';
import 'package:flutter_application_1/model/courseModel.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_application_1/screens/course_detail.dart';
import 'package:flutter_application_1/theme/color.dart';
import 'package:flutter_application_1/utils/data.dart';
import 'package:flutter_application_1/widgets/category_item.dart';
import 'package:flutter_application_1/widgets/course_item.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ExplorePage extends StatefulWidget {
  var _courseController;

  ExplorePage({Key? key}) : super(key: key) {
    _courseController = Get.find<courseController>();
  }

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {

  List<courseModel> updatedList = [], allList = [];
  TextEditingController searchValue = TextEditingController();
  String categoryValue = 'All';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allList = List.from(widget._courseController.allCourse);
    updatedList = allList;
  }
  void updateList() {
    // update list of courses
    if(categoryValue == 'All') {
      updatedList = List.from(allList.where((element) => element.toJSON()['title'].toLowerCase().contains(searchValue.text.toLowerCase())));
    }
    else {
      updatedList = List.from(allList.where(
        (element) => 
        element.toJSON()['title'].toLowerCase().contains(searchValue.text.toLowerCase())
        && element.toJSON()['category'] == categoryValue
      ));
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColor.appBarColor,
            pinned: true,
            title: getAppBar(),
          ),
          SliverToBoxAdapter(
            child: getSearchBox(),
          ),
          SliverToBoxAdapter(
            child: getCategories(),
          ),
          SliverList(delegate: getCourses()),
        ],
      ),
    );
  }

  getAppBar() {
    return Container(
      child: Row(children: [
        Text(
          "Explore",
          style: TextStyle(
            color: AppColor.textColor,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        )
      ]),
    );
  }

  getSearchBox() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 40,
              padding: EdgeInsets.only(bottom: 3),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: AppColor.shadowColor.withOpacity(.05),
                        spreadRadius: .5,
                        blurRadius: .5,
                        offset: Offset(0, 0))
                  ]),
              child: TextField(
                controller: searchValue,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 1),
                    border: InputBorder.none,
                    hintText: "Search",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 15)),
                    onChanged: (value) {
                      setState(() {
                        updateList();
                      });
                    },
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColor.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: SvgPicture.asset(
              "assets/icons/filter.svg",
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  getCategories() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(left: 15, top: 10, bottom: 15),
      child: Row(
        children: List.generate(
            categories.length,
            (index) => CategoryItem(
                onTap: () {
                  setState(() {
                    categoryValue = categories[index]['name'];
                    updateList();
                  });
                },
                isActive: categoryValue == categories[index]['name'],
                data: categories[index])),
      ),
    );
  }

  getCourses() {

    return SliverChildBuilderDelegate(
      (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      CourseDetailPage(data: {"course": updatedList[index].toJSON()})));
            },
            child: CourseItem(
              data: updatedList[index].toJSON(),
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
      childCount: updatedList.length,
    );
  }
}
