import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';


List<CameraDescription> cameras;

Future<void> main() async {
  cameras = await availableCameras();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      // This is the theme of your application.
      //
      // Try running your application with "flutter run". You'll see the
      // application has a blue toolbar. Then, without quitting the app, try
      // changing the primarySwatch below to Colors.green and then invoke
      // "hot reload" (press "r" in the console where you ran "flutter run",
      // or simply save your changes to "hot reload" in a Flutter IDE).
      // Notice that the counter didn't reset back to zero; the application
      // is not restarted.
      primarySwatch: Colors.blue,
    ),
    home: CameraApp(),
  ));
}
class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  int selectedCamera = 0;
  CameraController controller;
  CameraController frontController;
  @override
  void initState() {
    super.initState();
    SimplePermissions.checkPermission(Permission.WriteExternalStorage)
        .then((hasPermission) {
      if (!hasPermission) {
        SimplePermissions.requestPermission(Permission.WriteExternalStorage);
      }
    });
    initializeCamera();
  }
  initializeCamera() {
    controller = CameraController(cameras[selectedCamera], ResolutionPreset.medium);
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
  } 

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }

    return AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: Stack(
          children: <Widget>[
            CameraPreview(controller),
            Align(
              alignment: Alignment.bottomLeft,
              child: RaisedButton(child: Text("start"), onPressed: startVideo),
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: RaisedButton(child: Text("stop"), onPressed: stopVideo)),
            Align(
                alignment: Alignment.topRight,
                child: RaisedButton(child: Text("Toggle"), onPressed: toggleCamera)),                
          ],
        ));
  }
  void toggleCamera() {
    if (selectedCamera == 0) {
      selectedCamera = 1;
    } else {
      selectedCamera = 0;
    }
    // controller.dispose();
    initializeCamera();
  }

  //simple permissions removed due to build issues, new file path must be found or saved directly to firebase.
  void startVideo() async {
    String appDocDir = '';
    String appDocPath = appDocDir +
        "/video_" +
        DateTime.now().millisecondsSinceEpoch.toString()+".mp4";
    print("Before start");
    //controller.takePicture(appDocPath);
    controller.startVideoRecording(appDocPath);
    //.then(Future.delayed(100));
    print("After start");
  }

  void stopVideo() {
    print("Before stop");
    controller.stopVideoRecording();
    print("After stop");
  }
}