import 'package:drivecam/resources/colors.dart';
import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final Function onPress;
  final String text;
  SubmitButton(this.onPress, this.text);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Container(
        padding: EdgeInsets.only(
          top: 10,
          bottom: 10,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      color: AppColors.primaryColor,
      shape: StadiumBorder(),
      onPressed: onPress,
    );
  }
}
