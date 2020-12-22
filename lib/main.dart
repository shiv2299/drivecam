import 'package:drivecam/routes/router.dart';
import 'package:drivecam/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

import 'resources/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: AppColors.primaryColor,
        cursorColor: AppColors.primaryColor,
        inputDecorationTheme: InputDecorationTheme(
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 2.5),
          ),
          hintStyle: TextStyle(color: Colors.grey),
        ),
        textTheme: TextTheme(
          headline1: TextStyle(
              fontWeight: FontWeight.w900, fontSize: 24, color: Colors.black),
          bodyText1:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        fontFamily: "Poppins",
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
      onGenerateRoute: Router.generateRoute,
    );
  }
}
