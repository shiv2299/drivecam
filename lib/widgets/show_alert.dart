import 'package:drivecam/resources/colors.dart';
import 'package:flutter/material.dart';

class ShowAlert extends StatelessWidget {
  String title, content;
  ShowAlert(this.title, this.content);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        FlatButton(
          child: Text(
            "Close",
            style: TextStyle(color: AppColors.primaryColor),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
