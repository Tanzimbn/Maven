import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_application_1/theme/color.dart';

class NotificationBox extends StatefulWidget {
  NotificationBox({
    Key? key,
    this.onTap,
    this.size = 5,
    this.notifiedNumber = 0,
  }) : super(key: key);

  final GestureTapCallback? onTap;
  final int notifiedNumber;
  final double size;

  @override
  State<NotificationBox> createState() => _NotificationBoxState();
}

class _NotificationBoxState extends State<NotificationBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.all(widget.size),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColor.appBarColor,
          border: Border.all(
            color: Colors.grey.withOpacity(.3),
          ),
        ),
        child: widget.notifiedNumber > 0 ? _buildIconNotified() : _buildIcon(),
      ),
    );
  }

  Widget _buildIconNotified() {
    return badges.Badge(
      badgeStyle: badges.BadgeStyle(
        // shape: badges.BadgeShape.circle,
        // borderRadius: BorderRadius.circular(2),
        badgeColor: AppColor.actionColor,
        padding: EdgeInsets.all(3),
      ),
      position: badges.BadgePosition.topEnd(top: -7, end: -0),
      badgeContent: Text(
        // widget.notifiedNumber.toString(),
        '',
        style: TextStyle(color: Colors.white),
      ),
      child: _buildIcon(),
    );
  }

  Widget _buildIcon() {
    return SvgPicture.asset(
      "assets/icons/bell.svg",
      width: 20,
      height: 20,
    );
  }
}
