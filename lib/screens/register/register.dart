import 'package:drivecam/models/user_model.dart';
import 'package:drivecam/widgets/submit_button.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  Map<String, dynamic> data;

  Register(this.data);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _firstNameController;
  TextEditingController _lastNameController;
  TextEditingController _bloodGroupController;
  TextEditingController _kinController;
  TextEditingController _usernameController;
  TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();
  bool editable = true;
  register() async {
    User user = User(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      bloodGroup: _bloodGroupController.text.trim(),
      kinName: _kinController.text.trim(),
      username: _usernameController.text.trim(),
      password: _passwordController.text.trim(),
      faceData: "",
    );
    if (_formKey.currentState.validate()) {
      Navigator.of(context).pushReplacementNamed("/registerFace", arguments: {
        "user": user,
        "cd": widget.data["cd"],
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.data.containsKey("user")) {
      editable = false;
    }
    _firstNameController = TextEditingController(
        text: editable ? "" : widget.data["user"].displayName.split(" ")[0]);
    _lastNameController = TextEditingController(
        text: editable ? "" : widget.data["user"].displayName.split(" ").last);
    _bloodGroupController = TextEditingController();
    _kinController = TextEditingController();
    _usernameController =
        TextEditingController(text: editable ? "" : widget.data["user"].email);
    _passwordController = TextEditingController();
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
                    enabled: editable,
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
                    enabled: editable,
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
                    enabled: editable,
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
