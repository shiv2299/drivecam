import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:drivecam/db/database.dart';
import 'package:drivecam/services/facenet.service.dart';
import 'package:drivecam/services/ml_vision_service.dart';
import 'package:drivecam/services/user_api.dart';
import 'package:drivecam/widgets/elevated_button.dart';
import 'package:drivecam/widgets/loading_dialog.dart';
import 'package:drivecam/widgets/submit_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:local_auth/local_auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final LocalAuthentication auth = LocalAuthentication();
  FaceNetService _faceNetService = FaceNetService();
  MLVisionService _mlVisionService = MLVisionService();
  DataBaseService _dataBaseService = DataBaseService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FacebookLogin facebookSignIn = new FacebookLogin();
  String _message = 'Log in/out by pressing the buttons below.';
  FirebaseUser _user;
  CameraDescription cameraDescription;
  login() async {
    if (_formKey.currentState.validate()) {
      BuildContext loadContext;
      showDialog(
          context: context,
          builder: (ctx) {
            loadContext = ctx;
            return LoadingDialog("Logging in please wait..");
          },
          barrierDismissible: false);
      UserApi userApi = UserApi();
      String username = _usernameController.text.trim();
      String password = _passwordController.text.trim();
      try {
        Response response = await userApi.login(username, password);
        if (response.data["status"]) {
          String id = response.data["data"][0]["_id"];
          userApi.storeUserId(id);
          Navigator.pop(loadContext);
          Navigator.of(context).pushReplacementNamed("/home");
        } else {
          Navigator.pop(loadContext);
          Fluttertoast.showToast(msg: response.data["messages"]);
        }
      } catch (e) {
        print(e);
        Fluttertoast.showToast(msg: "Something Went Wrong!");
      }
    }
  }

  Future<Null> singInWithFaceBook() async {
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        _showMessage('''
         Logged in!
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
        print('''
         Logged in!
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions[1]}
         Declined permissions: ${accessToken.declinedPermissions}''');
        //    try {
        //   UserApi userApi = UserApi();
        //   Response response = await userApi.getUserByEmail(currentUser.email);
        //   print(response.data);
        //   if (response.data["status"]) {
        //     userApi.storeUserId(response.data["data"]["_id"]);
        //     Navigator.of(context).pushReplacementNamed("/home");
        //   } else {
        //     Navigator.of(context).pushNamed("/register",
        //         arguments: {"cd": cameraDescription, "user": currentUser});
        //   }
        // } catch (e) {
        //   print(e);
        //   Fluttertoast.showToast(msg: "Something Went Wrong!");
        // }
        break;
      case FacebookLoginStatus.cancelledByUser:
        _showMessage('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        _showMessage('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }
  // FaceBook logout
  // Future<Null> _logOut() async {
  //   await facebookSignIn.logOut();
  //   _showMessage('Logged out.');
  // }

  void _showMessage(String message) {
    setState(() {
      _message = message;
    });
    Fluttertoast.showToast(msg: _message);
  }

  void signInWithGoogle(context) async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    if (googleSignInAccount != null) {
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      AuthResult result = await _auth.signInWithCredential(credential);
      _user = result.user;
      assert(!_user.isAnonymous);
      assert(await _user.getIdToken() != null);
      FirebaseUser currentUser = await _auth.currentUser();
      assert(_user.uid == currentUser.uid);
      try {
        UserApi userApi = UserApi();
        Response response = await userApi.getUserByEmail(currentUser.email);
        print(response.data);
        if (response.data["status"]) {
          userApi.storeUserId(response.data["data"]["_id"]);
          Navigator.of(context).pushReplacementNamed("/home");
        } else {
          Navigator.of(context).pushNamed("/register",
              arguments: {"cd": cameraDescription, "user": currentUser});
        }
      } catch (e) {
        print(e);
        Fluttertoast.showToast(msg: "Something Went Wrong!");
      }
    }
  }

  _startUp() async {
    List<CameraDescription> cameras = await availableCameras();

    /// takes the front camera
    cameraDescription = cameras.firstWhere(
      (CameraDescription camera) =>
          camera.lensDirection == CameraLensDirection.front,
    );

    // start the services
    await _faceNetService.loadModel();
    await _dataBaseService.loadDB();
    _mlVisionService.initialize();
  }

  @override
  void initState() {
    super.initState();
    _startUp();
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
                                  Navigator.of(context).pushNamed("/register",
                                      arguments: {"cd": cameraDescription});
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
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 10, left: 10),
                          child: SizedBox(
                            width: double.infinity,
                            child: SubmitButton(
                              () {
                                signInWithGoogle(context);
                              },
                              "Sign in with Google",
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10, top: 10),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 10, left: 10),
                          child: SizedBox(
                            width: double.infinity,
                            child: SubmitButton(
                              () {
                                singInWithFaceBook();
                              },
                              "Sign in with Facebook",
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
                            child: CustomElevatedButton(
                              () {
                                Navigator.of(context).pushNamed('/loginFace',
                                    arguments: cameraDescription);
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
