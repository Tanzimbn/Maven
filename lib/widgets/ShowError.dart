import 'package:flutter/material.dart';

Future<void> _showError(BuildContext context, String mess) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error!'),
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.w600,
            color: Color.fromARGB(255, 255, 1, 1),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          content: Text(mess),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Ok'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 7, 123),
              ),
            ),
          ],
        );
      },
    );
  }