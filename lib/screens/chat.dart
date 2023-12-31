import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/data.dart';
import 'package:flutter_application_1/widgets/chat_item.dart';
import 'package:flutter_application_1/widgets/custom_textfield.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
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
            ),
          ),
          const SizedBox(height: 15),
          CustomTextBox(
            hint: "Search",
            prefix: Icon(
              Icons.search,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  _buildChats() {
    return ListView(
      padding: EdgeInsets.only(top: 10),
      shrinkWrap: true,
      children: List.generate(
        chats.length,
        (index) => ChatItem(
          chats[index],
        ),
      ),
    );
  }
}
