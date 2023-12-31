import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_application_1/theme/color.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem(
      {Key? key,
      required this.data,
      this.isActive = false,
      this.bgColor = Colors.white,
      this.onTap,
      this.activecolor = AppColor.primary})
      : super(key: key);
  final data;
  final Color activecolor;
  final Color bgColor;
  final bool isActive;
  final GestureTapCallback ? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve:  Curves.fastOutSlowIn,
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
              color: isActive ? activecolor : bgColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: AppColor.shadowColor.withOpacity(.05),
                  blurRadius: .5,
                  spreadRadius: .5,
                  offset: Offset(1, 1),
                )
              ]),
          child: Row(
            children: [
              SvgPicture.asset(
                data["icon"],
                color: isActive ? Colors.white : AppColor.darker,
                width: 16,
                height: 16,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                data["name"],
                style: TextStyle(color: isActive ? Colors.white : AppColor.darker,),
              ),
            ],
          )),
    );
  }
}
