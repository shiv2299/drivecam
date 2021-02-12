import 'package:dio/dio.dart';
import 'package:drivecam/resources/colors.dart';
import 'package:drivecam/resources/url.dart';
import 'package:drivecam/widgets/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PauseScreen extends StatefulWidget {
  @override
  _PauseScreenState createState() => _PauseScreenState();
}

class _PauseScreenState extends State<PauseScreen> {
  String selectedValue = "JOURNEY BREAK";

  updateJourney() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.get("trip");
    try {
      Dio dio = Dio();
      var url = "";
      if (selectedValue == "JOURNEY COMPLETED") {
        prefs.remove("trip");
        url = URL.url +
            "trip.php?trip_id=" +
            id +
            "&message=" +
            selectedValue +
            "&is_active=false";
      } else {
        url = URL.url + "trip.php?trip_id=" + id + "&message=" + selectedValue;
      }
      Response response = await dio.put(url);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  child: Icon(
                    Icons.person_outline,
                    color: AppColors.primaryColor,
                    size: 40,
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed("/profile");
                  },
                ),
              ),
              Text(
                "Please select reason",
                style: Theme.of(context).textTheme.headline1,
              ),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                margin: EdgeInsets.only(top: 15),
                child: Column(
                  children: [
                    RadioListTile(
                      value: "JOURNEY BREAK",
                      groupValue: selectedValue,
                      title: Text(
                        "10 min journey break",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      onChanged: (val) {
                        setState(() {
                          selectedValue = val;
                        });
                      },
                    ),
                    RadioListTile(
                      value: "LUNCH BREAK",
                      groupValue: selectedValue,
                      title: Text(
                        "Lunch break 1 hour",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      onChanged: (val) {
                        setState(() {
                          selectedValue = val;
                        });
                      },
                    ),
                    RadioListTile(
                      value: "VEHICLE ISSUE",
                      groupValue: selectedValue,
                      title: Text(
                        "Vehicle related issue",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      onChanged: (val) {
                        setState(() {
                          selectedValue = val;
                        });
                      },
                    ),
                    RadioListTile(
                      value: "ROAD BLOCK",
                      groupValue: selectedValue,
                      title: Text(
                        "Road block",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      onChanged: (val) {
                        setState(() {
                          selectedValue = val;
                        });
                      },
                    ),
                    RadioListTile(
                      value: "TCP ENTRY",
                      groupValue: selectedValue,
                      title: Text(
                        "TCP entry",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      onChanged: (val) {
                        setState(() {
                          selectedValue = val;
                        });
                      },
                    ),
                    RadioListTile(
                      value: "JOURNEY COMPLETED",
                      groupValue: selectedValue,
                      title: Text(
                        "Journey Completed",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      onChanged: (val) {
                        setState(() {
                          selectedValue = val;
                        });
                      },
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      margin: EdgeInsets.only(top: 20),
                      child: SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                          child: Container(
                            padding: EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                            ),
                            child: Text(
                              "Deactivate",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          color: AppColors.deactivateColour,
                          shape: StadiumBorder(),
                          onPressed: updateJourney,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                      margin: EdgeInsets.only(top: 20),
                      child: SizedBox(
                        width: double.infinity,
                        child: CustomElevatedButton(() {
                          Navigator.pop(context);
                        }, "Previous Page"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
