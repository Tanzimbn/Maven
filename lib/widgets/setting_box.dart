import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_application_1/theme/color.dart';

class SettingBox extends StatelessWidget {
  const SettingBox({
    Key? key,
    required this.title,
    required this.icon,
    this.color = AppColor.darker,
    this.onTap,
    this.isButton = false,
  }) : super(key: key);

  final title;
  final String icon;
  final Color color;
  final GestureTapCallback? onTap;
  final bool isButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColor.shadowColor.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: isButton ? GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            SvgPicture.asset(
              icon,
              color: color,
              width: 22,
              height: 22,
            ),
            const SizedBox(
              height: 7,
            ),
            Text(
              title,
              style: TextStyle(
                color: color,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      )
      : Column(
        children: [
          SvgPicture.asset(
            icon,
            color: color,
            width: 22,
            height: 22,
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
