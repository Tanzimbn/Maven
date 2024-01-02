import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/color.dart';
import 'package:flutter_application_1/widgets/custom_image.dart';

class RecommendItem extends StatelessWidget {
  const RecommendItem({
    Key? key,
    required this.data,
    this.onTap,
  }) : super(key: key);

  final data;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.all(10),
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(1, 1), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            CustomImage(
              data["img"],
              radius: 15,
              height: 80,
            ),
            const SizedBox(
              width: 10,
            ),
            _buildInfo()
          ],
        ),
      ),
    );
  }

  Widget _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data["title"],
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppColor.textColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          "BDT ${data["payment"]}",
          style: TextStyle(fontSize: 14, color: AppColor.textColor),
        ),
        const SizedBox(
          height: 15,
        ),
        _buildDurationAndRate()
      ],
    );
  }

  Widget _buildDurationAndRate() {
    return Row(
      children: [
        Icon(
          Icons.play_circle_outline,
          color: AppColor.labelColor,
          size: 14,
        ),
        const SizedBox(
          width: 2,
        ),
        Text(
          data["videos"].length.toString(),
          style: TextStyle(
            fontSize: 12,
            color: AppColor.labelColor,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Icon(
          Icons.star,
          color: AppColor.orange,
          size: 14,
        ),
        const SizedBox(
          width: 2,
        ),
        Text(
          data["rating"].toString(),
          style: TextStyle(
            fontSize: 12,
            color: AppColor.labelColor,
          ),
        )
      ],
    );
  }
}
