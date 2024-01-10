import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/color.dart';
import 'package:flutter_application_1/widgets/bookmark_box.dart';

class CourseItem extends StatelessWidget {
  const CourseItem({Key? key, required this.data, this.onBookmark}) : super(key: key);
  final data;
  final GestureTapCallback? onBookmark;
  @override
  Widget build(BuildContext context) {
    return Container(
            width: 200,
            height: 300,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: AppColor.shadowColor.withOpacity(.1),
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: Offset(1, 1))
                ]),
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  child: CachedNetworkImage(
                    imageBuilder: ((context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        )),
                    imageUrl: data["img"],
                  ),
                ),
                Positioned(
                  top: 175,
                  right: 15,
                  child: BookmarkBox(onTap: onBookmark, isBookmarked: false,)
                ),
                Positioned(
                    top: 215,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 60,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data["title"],
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              getAttribute(Icons.sell_outlined,
                                  "BDT ${data["payment"]}", AppColor.labelColor),
                              getAttribute(Icons.play_circle_outline,
                                  "${data["videos"].length} videos", AppColor.labelColor),
                              getAttribute(Icons.quiz_outlined,
                                  "${data["quizzes"].length} quiz", AppColor.labelColor),
                              getAttribute(Icons.star, data["rating"].toString(),
                                  Colors.yellow),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          );
  }
}

getAttribute(IconData icon, String name, Color color) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: color,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          name,
          style: TextStyle(
            fontSize: 13,
            color: AppColor.labelColor,
          ),
        )
      ],
    );
  }

