import 'package:audioplayers/audio_cache.dart';
import 'package:camera/camera.dart';
import 'package:drivecam/resources/colors.dart';
import 'package:drivecam/screens/start_journey/pause_screen.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:flutter_camera_ml_vision/flutter_camera_ml_vision.dart';
import 'package:fluttertoast/fluttertoast.dart';

class StartJourney extends StatefulWidget {
  @override
  _StartJourneyState createState() => _StartJourneyState();
}

class _StartJourneyState extends State<StartJourney> {
  final FaceDetector faceDetector = FirebaseVision.instance.faceDetector(
      FaceDetectorOptions(
          enableClassification: true, mode: FaceDetectorMode.fast));
  bool _isIncognito = false;
  static AudioCache player = new AudioCache();
  final alarmAudioPath = "siren.mp3";
  CameraLensDirection direction = CameraLensDirection.front;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    close();
    super.dispose();
  }

  close() async {
    await faceDetector.close();
  }

  detected(faces) {
    for (var face in faces) {
      print("LEFT" + face.leftEyeOpenProbability.toString());
      print("RIGHT" + face.leftEyeOpenProbability.toString());
      double left = face.leftEyeOpenProbability;
      double right = face.rightEyeOpenProbability;
      if (left <= 0.4 || right <= 0.4) {
        print("LEFT" + face.leftEyeOpenProbability.toString());
        print("RIGHT" + face.leftEyeOpenProbability.toString());
        player.play(alarmAudioPath);
        Fluttertoast.showToast(
            msg: "Eyes Closing",
            textColor: Colors.white,
            backgroundColor: Colors.red);
      } else {
//        player.fixedPlayer.stop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: CameraMlVision<List<Face>>(
              detector: faceDetector.processImage,
              onResult: (faces) {
                print("LENGTH");
                print(faces.length);
                detected(faces);
              },
              cameraLensDirection: direction,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              child: GestureDetector(
                child: Image.asset(
                  "assets/images/switch.png",
                  height: 45,
                  width: 50,
                ),
                onTap: () {
                  if (direction == CameraLensDirection.back) {
                    setState(() {
                      direction = CameraLensDirection.front;
                    });
                  } else {
                    setState(() {
                      direction = CameraLensDirection.back;
                    });
                  }
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    "SOS",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              onTap: () {},
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                left: 10, right: 10, top: MediaQuery.of(context).padding.top),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Switch(
                  value: _isIncognito,
                  onChanged: (value) {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => PauseScreen()));
                    setState(() {
                      _isIncognito = value;
                    });
                  },
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
        ],
      ),
    );
  }
}
