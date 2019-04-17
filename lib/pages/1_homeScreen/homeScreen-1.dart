
// Flutter Packages Import
import 'package:flutter/material.dart';

// Project Library Import
import '../../shelf.dart';


class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseBackground(_splashButtons(context), "assets/hum_shake_purp_middle.png");
  }
}

Widget _splashButtons(BuildContext context) {
  return Stack(
    children: <Widget>[

      CommonAppButtons(
        AppButtonType.NAVIGATION,
        "Sign-In",
        Alignment.center, 
        LoginExistingUser(new FireBaseAuthorization()),
        new BorderRadius.circular(40.0),
        new TextStyle(fontSize: 25)
        ),


      CommonAppButtons(
        AppButtonType.NAVIGATION,
        "New Account", 
        Alignment.bottomCenter,
        RegsiterNewUser(new FireBaseAuthorization()),
        new BorderRadius.circular(40.0),
        new TextStyle(fontSize: 25))]
  );
}

// Registration Button --> registerNewUser.dart