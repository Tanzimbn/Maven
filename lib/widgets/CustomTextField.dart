import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/theme/color.dart';

Widget CustomTextField(
      {String? title,
      String? hint,
      bool? isBig,
      BuildContext? context = null,
      bool? isPass = false,
      bool? isNumber = false,
      TextEditingController? textController}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color.fromARGB(183, 220, 220, 220)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: TextFormField(
              //expands: true,
              cursorColor: const Color.fromARGB(255, 243, 33, 107),
              controller: textController,
              maxLines: isBig == true ? 2 : 1,
              minLines: isBig == true ? 1 : 1,
              keyboardType: isBig == true
                  ? TextInputType.multiline
                  : isNumber == true
                      ? TextInputType.number
                      : TextInputType.text,
              obscureText: isPass == true ? true : false,
              inputFormatters: isNumber == true
                  ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
                  : <TextInputFormatter>[],

              decoration: InputDecoration(
                labelText: title,
                labelStyle: const TextStyle(
                  color: AppColor.inActiveColor,
                  fontWeight: FontWeight.w500,
                ),
                floatingLabelStyle: const TextStyle(
                  color: AppColor.secondary,
                  fontWeight: FontWeight.w500,
                ),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                  color: AppColor.secondary,
                )),
                border: InputBorder.none,
                hintText: hint,
              ),
            ),
          ),
        ],
      ),
    );
  }