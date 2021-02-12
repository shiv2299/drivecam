import 'dart:async';

import 'package:drivecam/services/user_api.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () => navigate());
  }

  navigate() async {
    String route = "/login";
    if (await UserApi().getUserId() != null) route = "/home";
    Navigator.of(context).pushReplacementNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/applogo.png"),
      ),
    );
  }
}
