
// Flutter Packages Import
import 'package:flutter/material.dart';

// Project Library Import
import '../shelf.dart';


class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseBackground(_splashButtons(context), "assets/hum_shake_purp_middle.png");
  }
}

Widget _splashButtons(BuildContext context) {
  return Stack(
    children: <Widget>[_registerButton(context), _signInButton(context)],
  );
}

// Registration Button --> registerNewUser.dart
Widget _registerButton(BuildContext context) {
  return Container(
      alignment: Alignment(-0.75, 0.85),
      child: MaterialButton(
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        onPressed: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RegsiterNewUser(new FireBaseAuthorization())))
            },
        child: new Text(
          'Register',
          style: new TextStyle(
            fontSize: 17.5,
          ),
        ),
        color: Colors.white,
        splashColor: Colors.purpleAccent,
        textColor: Colors.purple,
      ));
}

// Sign-In Button --> signinExistingUser.dart
Widget _signInButton(BuildContext context) {
  return Container(
      alignment: Alignment(0.75, 0.85),
      child: MaterialButton(
        onPressed: () => {Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginExistingUser(new FireBaseAuthorization())))},
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        child: new Text(
          'Sign-in',
          style: new TextStyle(
            fontSize: 17.5,
          ),
        ),
        color: Colors.white,
        splashColor: Colors.purpleAccent,
        textColor: Colors.purple,
      ));
}
