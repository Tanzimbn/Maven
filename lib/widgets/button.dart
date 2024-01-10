import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/color.dart';
import 'package:velocity_x/velocity_x.dart';
// import 'package:vaara_app/consts/consts.dart';

String p = 'Poppins';

Widget MyButton(
    {double? height, double? width, String? name, Function? whenPressed}) {
  height ??= 45;
  width ??= 20.0;

  return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            // side: const BorderSide(width: .5),
          ),
          onPressed: () {
            if (whenPressed != null) {
              whenPressed();
            } else {
              () {};
            }
          },
          child: name!.text.fontFamily(p).color(Colors.white).make())
      .box
      .height(height)
      .width(width)
      .roundedFull
      .make();
}