import 'package:drivecam/widgets/submit_button.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _bloodGroupController = TextEditingController();
  final _kinController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  register() async {
    Navigator.of(context).pushReplacementNamed("/login");
//    if (_formKey.currentState.validate()) {
//      BuildContext loadContext;
//      showDialog(
//          context: context,
//          builder: (ctx) {
//            loadContext = ctx;
//            return LoadingDialog("Creating account please wait..");
//          },
//          barrierDismissible: false);
//      try {
//        String firstName = _firstNameController.text.trim();
//        String lastName = _lastNameController.text.trim();
//        String bloodGroup = _bloodGroupController.text.trim();
//        String kinName = _kinController.text.trim();
//        String username = _usernameController.text.trim();
//        String password = _passwordController.text.trim();
//        var data = FormData.fromMap({
//          "first_name": firstName,
//          "last_name": lastName,
//          "blood_group": bloodGroup,
//          "kin_name": kinName,
//          "username": username,
//          "password": password
//        });
//        Dio dio = Dio();
//        Response response =
//            await dio.post(URL.url + "register.php", data: data);
//        if (response.statusCode == 200) {
//          if (json.decode(response.data)["status"]) {
//            Navigator.pop(loadContext);
//            Navigator.of(context).pushReplacementNamed("/login");
//          } else {
//            Navigator.pop(loadContext);
//            showDialog(
//                context: context,
//                builder: (ctx) {
//                  return ShowAlert("Error Creating Account!",
//                      json.decode(response.data)["message"]);
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
                children: [
                  Image.asset(
                    "assets/images/applogo.png",
                    height: 100,
                    width: 100,
                  ),
                  Text("Welcome", style: Theme.of(context).textTheme.headline1),
                  TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(hintText: "First Name"),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter first name";
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: InputDecoration(hintText: "Last Name"),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter last name";
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _bloodGroupController,
                    decoration: InputDecoration(hintText: "Blood Group"),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter blood group";
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _kinController,
                    decoration: InputDecoration(hintText: "Name Of Kin"),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter name of kin";
                      } else {
                        return null;
                      }
                    },
                  ),
//                TextFormField(
//                  decoration: InputDecoration(hintText: "Unit Code"),
//                ),
//                TextFormField(
//                  decoration: InputDecoration(hintText: "Role"),
//                ),
                  TextFormField(
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
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(hintText: "Password"),
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter password";
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Confirm Password"),
                    obscureText: true,
                    validator: (value) {
                      if (value != _passwordController.text) {
                        return "Password does not match";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 15, right: 15),
                    width: double.infinity,
                    child: SubmitButton(register, "Register"),
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
