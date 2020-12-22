import 'package:drivecam/resources/colors.dart';
import 'package:drivecam/widgets/elevated_button.dart';
import 'package:drivecam/widgets/submit_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
//  Trip trip;
//  bool isLoaded = false;
//  bool tripAvailable = false;

//  getData() async {
//    SharedPreferences pref = await SharedPreferences.getInstance();
//    String id = pref.get("id");
//    try {
//      Dio dio = Dio();
//      Response response = await dio.get(URL.url + "trip.php?id=" + id);
//      print(response.data);
//      if (response.statusCode == 200) {
//        trip = Trip.fromRawJson(response.data);
//        if (trip.status) {
//          setState(() {
//            isLoaded = true;
//            tripAvailable = true;
//          });
//        } else {
//          setState(() {
//            isLoaded = true;
//          });
//        }
//      }
//    } catch (e) {
//      print(e);
//      FlutterToast(context).showToast(
//          child: Text("Something went wrong!"),
//          gravity: ToastGravity.BOTTOM,
//          toastDuration: Duration(seconds: 2));
//    }
//  }

  startJourney() async {
//    SharedPreferences pref = await SharedPreferences.getInstance();
//    try {
//      Dio dio = Dio();
//      Response response = await dio.put(URL.url +
//          "trip.php?trip_id=" +
//          trip.data.id.toString() +
//          "&message=STARTED");
//      print(response.data);
//      if (response.statusCode == 200) {
//        var data = json.decode(response.data);
//        if (data["status"]) {
//          pref.setString("trip", trip.data.id.toString());
//          Navigator.of(context).pushNamed("/start_journey");
//        }
//      }
//    } catch (e) {}
    Navigator.of(context).pushNamed("/start_journey");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Icon(
                      Icons.home,
                      color: AppColors.primaryColor,
                      size: 40,
                    ),
                    onTap: () {},
                  ),
                  GestureDetector(
                    child: Icon(
                      Icons.person_outline,
                      color: AppColors.primaryColor,
                      size: 40,
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed("/profile");
                    },
                  ),
                ],
              ),
            ),
            Container(
              child: Text(
                "Start The Journey",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
//            isLoaded
//                ? tripAvailable
//                    ?
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: TextFormField(
//                                      initialValue: trip.data.from,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              hintText: "From",
                            ),
                            enabled: false,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: TextFormField(
//                                      initialValue: trip.data.to,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              hintText: "To",
                              enabled: false,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              hintText: "Authentication code",
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, bottom: 15),
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: SizedBox(
                            width: double.infinity,
                            child: SubmitButton(startJourney, "Begin Journey"),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text("If you don't have authentication code"),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          padding:
                              EdgeInsets.only(left: 5, right: 5, bottom: 15),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(() {}, "Request Code"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
//                    : Expanded(child: Center(child: Text("No trips available")))
//                : Expanded(
//                    child: Center(
//                      child: CircularProgressIndicator(),
//                    ),
//                  ),
          ],
        ),
      ),
    );
  }
}
