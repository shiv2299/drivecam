import 'package:dio/dio.dart';
import 'package:drivecam/models/user_model.dart';
import 'package:drivecam/resources/colors.dart';
import 'package:drivecam/services/facenet.service.dart';
import 'package:drivecam/services/user_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthActionButton extends StatefulWidget {
  AuthActionButton(
    this._initializeControllerFuture, {
    @required this.onPressed,
    @required this.isLogin,
    this.user,
    @required this.context,
  });
  final Future _initializeControllerFuture;
  final Function onPressed;
  final bool isLogin;
  final User user;
  final context;
  @override
  _AuthActionButtonState createState() => _AuthActionButtonState();
}

class _AuthActionButtonState extends State<AuthActionButton> {
  final FaceNetService _faceNetService = FaceNetService();
  final UserApi userApi = UserApi();
  User predictedUser;

  Future _signUp() async {
    List predictedData = _faceNetService.predictedData;
    User user = widget.user;
    user.faceData = predictedData.join(",");
    try {
      Response response = await userApi.register(user);
      print(response.data);
      if (response.data["status"]) {
        this._faceNetService.setPredictedData(null);
        userApi.storeUserId(response.data["data"]["_id"].toString());
        Fluttertoast.showToast(msg: "Registration Successful");
        Navigator.of(widget.context).pushReplacementNamed("/login");
      } else {
        Navigator.pop(widget.context);
        Fluttertoast.showToast(msg: response.data["messages"]["success"]);
      }
    } catch (e) {
      print("ERROR");
      print(e);
      FirebaseAuth.instance.signOut();
      GoogleSignIn().signOut();
      Fluttertoast.showToast(msg: "Something Went Wrong!");
    }
  }

  Future _signIn() async {
    List predictedData = _faceNetService.predictedData;
    try {
      Response response = await userApi.loginFace(predictedData.join(","));
      print(response.data);
      if (response.data["status"]) {
        this._faceNetService.setPredictedData(null);
        userApi.storeUserId(response.data["data"]["_id"]);
        Fluttertoast.showToast(
            msg: "Welcome " + response.data["data"]["first_name"]);
        Navigator.of(widget.context).pushReplacementNamed("/home");
      } else {
        Navigator.pop(widget.context);
        Fluttertoast.showToast(msg: response.data["messages"]);
      }
    } catch (e) {
      print("ERROR");
      print(e);
      Fluttertoast.showToast(msg: "Something Went Wrong!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: AppColors.primaryColor,
      label: widget.isLogin ? Text('Sign in') : Text('Sign up'),
      icon: Icon(Icons.camera_alt),
      onPressed: () async {
        // try {
        await widget._initializeControllerFuture;
        bool faceDetected = await widget.onPressed();
        if (faceDetected) {
          if (widget.isLogin) {
            await _signIn();
          } else if (!widget.isLogin) {
            await _signUp();
          }
        }
        // } catch (e) {
        //   print(e);
        // }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
