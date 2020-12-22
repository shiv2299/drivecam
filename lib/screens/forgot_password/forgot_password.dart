import 'package:drivecam/widgets/elevated_button.dart';
import 'package:drivecam/widgets/submit_button.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 25, right: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/applogo.png",
                  height: 50,
                  width: 50,
                ),
                SizedBox(
                  width: 10,
                ),
                Text("Forgot Password",
                    style: Theme.of(context).textTheme.headline1),
              ],
            ),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(hintText: "Unit Code"),
                      ),
                      TextFormField(
                        decoration:
                            InputDecoration(hintText: "Initial Password"),
                        obscureText: true,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Center(
                            child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    () {}, "Initiate Verification"))),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text("Verification Pending",
                          style: Theme.of(context).textTheme.headline1),
                      TextFormField(
                        decoration: InputDecoration(hintText: "New Password"),
                        obscureText: true,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Center(
                            child: SizedBox(
                                width: double.infinity,
                                child: SubmitButton(() {}, "Sign in"))),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
