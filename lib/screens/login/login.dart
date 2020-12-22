import 'package:drivecam/widgets/elevated_button.dart';
import 'package:drivecam/widgets/submit_button.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  login() async {
    Navigator.of(context).pushReplacementNamed('/home');
//    if (_formKey.currentState.validate()) {
//      BuildContext loadContext;
//      showDialog(
//          context: context,
//          builder: (ctx) {
//            loadContext = ctx;
//            return LoadingDialog("Logging in please wait..");
//          },
//          barrierDismissible: false);
//      try {
//        String username = _usernameController.text.trim();
//        String password = _passwordController.text.trim();
//        Dio dio = Dio();
//        var data =
//            FormData.fromMap({"username": username, "password": password});
//        Response response = await dio.post(URL.url + "login.php", data: data);
//        print(response.data);
//        if (response.statusCode == 200) {
//          User user = User.fromRawJson(response.data);
//          if (user.status) {
//            Navigator.pop(loadContext);
//            SharedPreferences pref = await SharedPreferences.getInstance();
//            pref.setBool("isLoggedIn", true);
//            pref.setString("id", user.data.id);
//            Navigator.of(context).pushReplacementNamed('/home');
//          } else {
//            Navigator.pop(loadContext);
//            showDialog(
//                context: context,
//                builder: (ctx) {
//                  return ShowAlert("Error Logging in!", user.message);
//                });
//          }
//        } else {
//          Navigator.pop(loadContext);
//          FlutterToast(context).showToast(
//              child: Text("Something went wrong!"),
//              gravity: ToastGravity.BOTTOM,
//              toastDuration: Duration(seconds: 2));
//        }
//      } catch (e) {
//        print(e);
//        Navigator.pop(loadContext);
//        FlutterToast(context).showToast(
//            child: Text("Something went wrong!"),
//            gravity: ToastGravity.BOTTOM,
//            toastDuration: Duration(seconds: 2));
//      }
//    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.only(
            left: 25,
            right: 25,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/applogo.png",
                    height: 100,
                    width: 100,
                  ),
                  Text("Welcome", style: Theme.of(context).textTheme.headline1),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Image.asset(
                            "assets/images/username_icon.png",
                            height: 25,
                            width: 25,
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _usernameController,
                            decoration: InputDecoration(hintText: "Username"),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Enter username";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Image.asset(
                            "assets/images/password_icon.png",
                            height: 25,
                            width: 25,
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              hintText: "Password",
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Enter password";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 35, top: 15),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                child: Text(
                                  "New User",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                onTap: () {
                                  Navigator.of(context).pushNamed("/register");
                                },
                              ),
                              GestureDetector(
                                child: Text(
                                  "Forgot Password?",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed("/forgot_password");
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 10, left: 10),
                          child: SizedBox(
                            width: double.infinity,
                            child: SubmitButton(
                              login,
                              "Sign in",
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 15, top: 15),
                          child: Text(
                            "Or",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(bottom: 20, right: 10, left: 10),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              () {
                                print("Face Recognition");
                              },
                              "Face Recognition",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
