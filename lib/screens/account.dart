import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/enrolledController.dart';
import 'package:flutter_application_1/screens/auth/login.dart';
import 'package:flutter_application_1/screens/enroll_course.dart';
import 'package:flutter_application_1/screens/my_course.dart';
import 'package:flutter_application_1/screens/payment.dart';
import 'package:flutter_application_1/theme/color.dart';
import 'package:flutter_application_1/utils/data.dart';
import 'package:flutter_application_1/widgets/custom_image.dart';
import 'package:flutter_application_1/widgets/setting_box.dart';
import 'package:flutter_application_1/widgets/setting_item.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AccountPage extends StatefulWidget {

  AccountPage({Key? key}) : super(key: key){}

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
            backgroundColor: AppColor.appBgColor,
            pinned: true,
            centerTitle: true,
            title: Text(
              "My Profile",
              style: TextStyle(
                color: AppColor.textColor,
                // fontWeight: FontWeight.w600,
                fontSize: 24,
                fontFamily: 'Oswald',
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                'assets/icons/logo_blackColor.svg',
                // color: AppColor.textColor,
                width: 10,
                height: 10,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        SliverToBoxAdapter(child: _buildBody())
      ],
    );
  }

  _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Account",
          style: TextStyle(
            color: AppColor.textColor,
            fontSize: 24,
            fontWeight: FontWeight.w600,
            fontFamily: 'Oswald',
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          _buildProfile(),
          const SizedBox(
            height: 20,
          ),
          _buildRecord(),
          const SizedBox(
            height: 20,
          ),
          _buildSection1(),
          const SizedBox(
            height: 20,
          ),
          _buildSection2(),
          const SizedBox(
            height: 20,
          ),
          _buildSection3(),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildProfile() {
    return Column(
      children: [
        CustomImage(
          profile["img"].toString(),
          width: 100,
          height: 100,
          radius: 20,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          profile["name"].toString(),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            // fontFamily: 'Oswald',
          ),
        ),
      ],
    );
  }

  Widget _buildRecord() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SettingBox(
            title: "Courses",
            icon: "assets/icons/enroll.svg",
            // color: AppColor.sky,
            isButton: true,
            onTap : () {
              setState(() {
                Get.find<enrolledController>().allCourse.length;
              });
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      enrollCourse()));
            }
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: SettingBox(
            title: "Coins",
            icon: "assets/icons/coin.svg",
            isButton: true,
            onTap: () {
              setState(() {
                profile['point'];
              });
              _showError(context, "Total coins ", "${profile['point']}");
            },
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: SettingBox(
            title: "Balance",
            icon: "assets/icons/money.svg",
            isButton: true,
            onTap: () {
              setState(() {
                profile['money'];
              });
              _showError(context, "Total balance ", "${profile['money']} BDT");
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSection1() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColor.cardColor,
        boxShadow: [
          BoxShadow(
            color: AppColor.shadowColor.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          SettingItem(
            title: "Edit profile",
            leadingIcon: "assets/icons/edit.svg",
            bgIconColor: AppColor.blue,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 45),
            child: Divider(
              height: 0,
              color: Colors.grey.withOpacity(0.8),
            ),
          ),
          SettingItem(
            title: "Your Courses",
            leadingIcon: "assets/icons/container.svg",
            bgIconColor: AppColor.green,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      myCourse()));
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 45),
            child: Divider(
              height: 0,
              color: Colors.grey.withOpacity(0.8),
            ),
          ),
          SettingItem(
            title: "Bookmark",
            leadingIcon: "assets/icons/bookmark.svg",
            bgIconColor: AppColor.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildSection2() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColor.cardColor,
        boxShadow: [
          BoxShadow(
            color: AppColor.shadowColor.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          SettingItem(
            title: "Payment",
            leadingIcon: "assets/icons/wallet.svg",
            bgIconColor: AppColor.purple,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      PaymentPage()));
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 45),
            child: Divider(
              height: 0,
              color: Colors.grey.withOpacity(0.8),
            ),
          ),
          SettingItem(
            title: "Help Center",
            leadingIcon: "assets/icons/help.svg",
            bgIconColor: AppColor.yellow,
          ),
          
          // SettingItem(
          //   title: "Log Out",
          //   leadingIcon: "assets/icons/logout.svg",
          //   bgIconColor: AppColor.darker,
          //   onTap: () async {
          //     context.read<AuthenticationService>().SignOut();
          //   },
          // ),
        ],
      ),
    );
  }

  Widget _buildSection3() {
    return GestureDetector(
      onTap: () async {
        // await _firebaseauth.signOut();
        FirebaseAuth.instance.signOut();
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) =>
          LogIn()));
      },
      child: Center(
        child: Container(
          // width: 150,
          padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
          decoration: BoxDecoration(
            color: AppColor.primary,
            borderRadius: BorderRadius.circular(30)
          ),
          child: Center(
            child: Text(
              "Logout",
              style: TextStyle(
                color: Colors.white,
                  fontSize: 20.0,
                  fontFamily: 'Oswald',
                  fontWeight: FontWeight.bold),
            )),
        ),
      ),);
  }

  Future<void> _showError(BuildContext context, String title, String mess) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColor.textColor,
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          content: Text(mess, style: TextStyle(
            fontWeight:FontWeight.bold
          ),),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Ok', style: TextStyle(color: Colors.white),),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primary,
              ),
            ),
          ],
        );
      },
    );
  }

}
