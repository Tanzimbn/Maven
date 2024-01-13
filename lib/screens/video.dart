

import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/color.dart';

class VideoPage extends StatefulWidget {
  VideoPage({Key? key, required this.data, required this.complete}) : super(key: key);
  final data;
  bool complete = false;
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {

  String title = "";
  String url = "";
  bool complete = false;

  void initState() {
    super.initState();
    title = widget.data['title'];
    url = widget.data['url'];
    complete = widget.complete;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: buildAppbar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("asa"),
          ],
        ),
      )
    );
  }

  AppBar buildAppbar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: Padding(
        padding: EdgeInsets.only(left: 0),
        child: Center(
          child: Text(
            title,
            style: TextStyle(color: AppColor.textColor),
          ),
        ),
      ),
      iconTheme: IconThemeData(color: AppColor.textColor),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

}
