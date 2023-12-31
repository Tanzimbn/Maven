
import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const RoundButton({Key? key, required this.title, required this.onTap}) : super(key:key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 7, 131),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Center(child: Text(title, style: TextStyle(
          color: Colors.white,
        ),),),
      ),
    );
  }

}