import 'package:drivecam/resources/colors.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Function onPress;
  final String text;
  CustomElevatedButton(this.onPress, this.text);

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
            color: AppColors.primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      color: Colors.white,
      shape: StadiumBorder(),
      onPressed: onPress,
      elevation: 7,
    );
  }
}
