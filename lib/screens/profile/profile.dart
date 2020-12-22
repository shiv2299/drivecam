import 'package:drivecam/resources/colors.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _isIncognito = false;
  bool _isLiveTracking = true;
//  bool isLoaded = false;
//  User user;
//  getData() async {
//    SharedPreferences pref = await SharedPreferences.getInstance();
//    String id = pref.getString("id");
//    try {
//      Dio dio = Dio();
//      Response response = await dio.get(URL.url + "user.php?id=" + id);
//      if (response.statusCode == 200) {
//        print(response.data);
//        setState(() {
//          user = User.fromRawJson(response.data[0]);
//          isLoaded = true;
//        });
//      }
//    } catch (e) {
//      print(e);
//    }
//  }

  @override
  void initState() {
    super.initState();
//    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                color: AppColors.primaryColor,
                child:
//              isLoaded
//                  ?
                    Row(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.width * 0.33,
                      width: MediaQuery.of(context).size.width * 0.33,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.person,
                          color: AppColors.primaryColor,
                          size: MediaQuery.of(context).size.width * 0.15),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Name",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 24),
                        ),
                        Text(
                          "Unit Code ", //+ user.data.unitCode,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
//                  : Container(),
                ),
          ),
          Expanded(
            flex: 4,
            child: Container(
                color: AppColors.primaryColorLight,
                padding: EdgeInsets.only(left: 10),
                child:
//              isLoaded
//                  ?
                    SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "User Details",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.1),
                        child: Column(
                          children: [
                            TextFormField(
                              initialValue: "First Name", //user.data.firstName,
                              enabled: false,
                            ),
                            TextFormField(
                              initialValue: "Last name", //user.data.lastName,
                              enabled: false,
                            ),
                            TextFormField(
                              initialValue: "Kin Name", //user.data.kinName,
                              enabled: false,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "User Settings",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Incognito Mode",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                Switch(
                                  value: _isIncognito,
                                  onChanged: (value) {
                                    setState(() {
                                      _isIncognito = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                            Text(
                              "Entering this mode will disable your location or log generation or live report",
                              style: TextStyle(height: 1),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Change Role",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Live Tracking",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                Checkbox(
                                  value: _isLiveTracking,
                                  onChanged: (value) {
                                    setState(() {
                                      _isLiveTracking = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                            Text(
                              "Disabling will restrict supervisor to track",
                              style: TextStyle(height: 1),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            InkWell(
                              child: Text(
                                "Delete Profile",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Approval Pending",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w900),
                            ),
                            GestureDetector(
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                child: Center(
                                  child: Text(
                                    "Save",
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
//                  : Center(
//                      child: CircularProgressIndicator(),
//                    ),
                ),
          ),
        ],
      ),
    );
  }
}
