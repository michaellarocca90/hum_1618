
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

      CommonAppButtons.navigation(
        AppButtonType.NAVIGATION,
        "Sign-In",
        Alignment.center,
        new BorderRadius.circular(40.0),
        new TextStyle(fontSize: 25),
        LoginExistingUser(new FireBaseAuthorization())
        ),


      CommonAppButtons.navigation(
        AppButtonType.NAVIGATION,
        "New Account", 
        Alignment.bottomCenter,
        new BorderRadius.circular(40.0),
        new TextStyle(fontSize: 25),
        RegsiterNewUser(new FireBaseAuthorization()))]
  );
}

// Registration Button --> registerNewUser.dart