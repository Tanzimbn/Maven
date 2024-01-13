import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/noticationController.dart';
import 'package:flutter_application_1/model/notification.dart';
import 'package:flutter_application_1/widgets/chat_item.dart';
import 'package:get/get.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage({Key? key}) : super(key: key) {}

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  
  List<notificationModel> temp = [], _notifications = [];
  void initState() {
    super.initState();
    temp = List.from(
      Get.find<notificationController>().allnotification
      .where((element) => element.toJSON()['user_id'] == FirebaseAuth.instance.currentUser!.uid)
    );
    _notifications = temp.reversed.toList();

  }
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          _buildHeader(),
          _buildChats(),
        ],
      ),
    );
  }

  _buildHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 60, 0, 5),
      child: Column(
        children: [
          Text(
            "Notifications",
            style: TextStyle(
              fontSize: 28,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontFamily: 'Oswald',
            ),
          ),
          const SizedBox(height: 15),
          // CustomTextBox(
          //   hint: "Search",
          //   prefix: Icon(
          //     Icons.search,
          //     color: Colors.grey,
          //   ),
          // ),
        ],
      ),
    );
  }

  _buildChats() {
    return ListView.builder(
      padding: EdgeInsets.only(top: 10),
      shrinkWrap: true,
      itemCount: _notifications.length,
      itemBuilder:(context, index) => ChatItem(
          chatData: _notifications[index],
          ontap: () {
            setState(() {
              _notifications[index].seen = false;
            });
          },
        ),
      );
  }
}
