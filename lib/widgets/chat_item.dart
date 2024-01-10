import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/noticationController.dart';
import 'package:flutter_application_1/model/notification.dart';
import 'package:flutter_application_1/theme/color.dart';
import 'package:get/get.dart';
import 'chat_notify.dart';
import 'custom_image.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({
    Key? key,
    this.chatData,
    required this.ontap,
  }) : super(key: key);

  final chatData;
  final Function() ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.find<notificationController>().updateNotification(chatData.id ,FirebaseAuth.instance.currentUser!.uid.toString());
        ontap;
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.fromLTRB(10, 12, 10, 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(1, 1),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // _buildPhoto(),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                children: [
                  buildNameAndTime(),
                  const SizedBox(
                    height: 5,
                  ),
                  _buildTextAndNotified(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextAndNotified() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            chatData.message,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 13),
          ),
        ),
        if (chatData.seen == false)
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Icon(
              Icons.circle_notifications,
              color: AppColor.primary,
            ),
          )
      ],
    );
  }

  // Widget _buildPhoto() {
  //   return CustomImage(
  //     chatData['image'],
  //     width: profileSize,
  //     height: profileSize,
  //   );
  // }

  Widget buildNameAndTime() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Text(
            chatData.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(width: 5),
        // Text(
        //   chatData['date'],
        //   maxLines: 1,
        //   overflow: TextOverflow.ellipsis,
        //   style: TextStyle(
        //     fontSize: 11,
        //     color: Colors.grey,
        //   ),
        // )
      ],
    );
  }
}
