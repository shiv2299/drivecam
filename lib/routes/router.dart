import 'package:drivecam/screens/forgot_password/forgot_password.dart';
import 'package:drivecam/screens/home/home.dart';
import 'package:drivecam/screens/login/login.dart';
import 'package:drivecam/screens/login/login_face.dart';
import 'package:drivecam/screens/profile/profile.dart';
import 'package:drivecam/screens/register/register.dart';
import 'package:drivecam/screens/register/register_face.dart';
import 'package:drivecam/screens/splash_screen/splash_screen.dart';
import 'package:drivecam/screens/start_journey/start_journey.dart';
import 'package:flutter/material.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/splash':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => Login());
      case '/register':
        return MaterialPageRoute(builder: (_) => Register(settings.arguments));
      case '/forgot_password':
        return MaterialPageRoute(builder: (_) => ForgotPassword());
      case '/home':
        return MaterialPageRoute(builder: (_) => Home());
      case '/profile':
        return MaterialPageRoute(builder: (_) => Profile());
      case '/start_journey':
        return MaterialPageRoute(builder: (_) => StartJourney());
      case '/registerFace':
        return MaterialPageRoute(
            builder: (_) => RegisterFace(settings.arguments));
      case '/loginFace':
        return MaterialPageRoute(builder: (_) => LoginFace(settings.arguments));
    }
  }
}
