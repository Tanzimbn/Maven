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
            height: 290,
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
                    imageUrl: data["image"],
                  ),
                ),
                Positioned(
                  top: 175,
                  right: 15,
                  child: BookmarkBox(onTap: onBookmark, isBookmarked: data["is_favorited"],)
                ),
                Positioned(
                    top: 215,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 60,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data["name"],
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
                                  data["price"], AppColor.labelColor),
                              getAttribute(Icons.play_circle_outline,
                                  data["session"], AppColor.labelColor),
                              getAttribute(Icons.schedule_outlined,
                                  data["duration"], AppColor.labelColor),
                              getAttribute(Icons.star, data["review"].toString(),
                                  Colors.yellow),
                            ],
                          )
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

