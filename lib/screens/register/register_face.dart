import 'dart:io';
import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:drivecam/services/camera.service.dart';
import 'package:drivecam/services/facenet.service.dart';
import 'package:drivecam/services/ml_vision_service.dart';
import 'package:drivecam/widgets/FacePainter.dart';
import 'package:drivecam/widgets/auth-action-button.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

class RegisterFace extends StatefulWidget {
  final data;

  RegisterFace(this.data);

  @override
  _RegisterFaceState createState() => _RegisterFaceState();
}

class _RegisterFaceState extends State<RegisterFace> {
  String imagePath;
  Face faceDetected;
  Size imageSize;
  bool _detectingFaces = false;
  bool pictureTaken = false;

  Future _initializeControllerFuture;
  bool cameraInitialized = false;

  bool _saving = false;
  bool _bottomSheetVisible = false;

  MLVisionService _mlVisionService = MLVisionService();
  CameraService _cameraService = CameraService();
  FaceNetService _faceNetService = FaceNetService();

  @override
  void initState() {
    super.initState();
    _start();
  }

  @override
  void dispose() {
    _cameraService.dispose();
    super.dispose();
  }

  _start() async {
    _initializeControllerFuture =
        _cameraService.startService(widget.data["cd"]);
    await _initializeControllerFuture;

    setState(() {
      cameraInitialized = true;
    });

    _frameFaces();
  }

  Future<void> onShot() async {
    print('onShot performed');

    if (faceDetected == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                content: Text('No face detected!'),
              ));

      return false;
    } else {
      imagePath =
          join((await getTemporaryDirectory()).path, '${DateTime.now()}.png');

      _saving = true;

      await Future.delayed(Duration(milliseconds: 500));
      await _cameraService.cameraController.stopImageStream();
      await Future.delayed(Duration(milliseconds: 200));
      await _cameraService.takePicture(imagePath);

      setState(() {
        _bottomSheetVisible = true;
        pictureTaken = true;
      });

      return true;
    }
  }

  _frameFaces() {
    imageSize = _cameraService.getImageSize();

    _cameraService.cameraController.startImageStream((image) async {
      if (_cameraService.cameraController != null) {
        if (_detectingFaces) return;

        _detectingFaces = true;

        try {
          List<Face> faces = await _mlVisionService.getFacesFromImage(image);

          if (faces.length > 0) {
            setState(() {
              faceDetected = faces[0];
            });

            if (_saving) {
              _faceNetService.setCurrentPrediction(image, faceDetected);
              setState(() {
                _saving = false;
              });
            }
          } else {
            setState(() {
              faceDetected = null;
            });
          }

          _detectingFaces = false;
        } catch (e) {
          print(e);
          _detectingFaces = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double mirror = math.pi;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (pictureTaken) {
                return Container(
                  width: width,
                  child: Transform(
                      alignment: Alignment.center,
                      child: Image.file(File(imagePath)),
                      transform: Matrix4.rotationY(mirror)),
                );
              } else {
                return Transform.scale(
                  scale: 1.0,
                  child: AspectRatio(
                    aspectRatio: MediaQuery.of(context).size.aspectRatio,
                    child: OverflowBox(
                      alignment: Alignment.center,
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Container(
                          width: width,
                          height: width /
                              _cameraService.cameraController.value.aspectRatio,
                          child: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              CameraPreview(_cameraService.cameraController),
                              CustomPaint(
                                painter: FacePainter(
                                    face: faceDetected, imageSize: imageSize),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: !_bottomSheetVisible
            ? AuthActionButton(
                _initializeControllerFuture,
                user: widget.data["user"],
                onPressed: onShot,
                isLogin: false,
                context: context,
              )
            : Container());
  }
}
