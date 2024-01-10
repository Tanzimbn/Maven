import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/quiz.dart';
import 'package:flutter_application_1/theme/color.dart';
import 'package:flutter_application_1/widgets/custom_image.dart';

class excerciseItem extends StatelessWidget {
  const excerciseItem({
    Key? key, 
    this.data,
    required this.enrolled,
    this.complete = false,
    this.ongoing = false,
  }) : super(key: key);
  final data;
  final bool enrolled;
  final bool complete;
  final bool ongoing;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColor.shadowColor.withOpacity(.07),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(1, 1),
              )
            ]),
        child: Row(children: [
          Icon(Icons.quiz_outlined ,color: AppColor.secondary,size: 15,),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data['quiz']["title"],
                  style: TextStyle(
                    color: AppColor.textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: enrolled ? 10 : 0,
                ),
                enrolled ?
                Row(
                  children: [
                    Icon(
                      complete ? Icons.done_outline : Icons.pending_outlined,
                      color: complete? AppColor.green : ongoing ? AppColor.yellow : AppColor.red,
                      size: 14,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      complete ? "Complete" : "Not complete",
                      style: TextStyle(
                        color: complete? AppColor.green : AppColor.yellow,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ) 
                :SizedBox(),
              ],
            ),
          ),
          ongoing ?
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) =>
                      QuizPage(data: data)));
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(AppColor.primary),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
            ),
            child: Icon(Icons.arrow_forward_ios_rounded,color: AppColor.labelColor,size: 15,),
          )
          :SizedBox(),
        ]),
      );
  }
}