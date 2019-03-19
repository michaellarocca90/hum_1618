import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(HumApp());

class HumApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        primarySwatch: Colors.purple,
      ),
      title: 'Hüm',
      home: SplashPage(),
    );
  }
}

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          'assets/Splash_4.jpg',
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 120.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: RaisedButton(
              color: Colors.deepPurple,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              child: Padding(
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                padding: EdgeInsets.all(5),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterPage()));
              },
            ),
          ),
        )
      ],
    );
  }
}

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          'assets/hum_shake_purp_large.jpg',
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
        SafeArea(
          child: Flex(
            mainAxisSize: MainAxisSize.max,
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                  child: CupertinoTextField(
                placeholder: "Name",
                autofocus: true,
              )),
            ],
          ),
        ),
      ],
    );
  }
}
