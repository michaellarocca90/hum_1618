
import 'package:flutter/material.dart';

import '../../shelf.dart';


class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseBackground("assets/hum_shake_purp_middle.png", _splashButtons(context));
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
        LogIN(new FireBaseAuthorization())
        ),


      CommonAppButtons.navigation(
        AppButtonType.NAVIGATION,
        "New Account", 
        Alignment.bottomCenter,
        new BorderRadius.circular(40.0),
        new TextStyle(fontSize: 25),
        NewUser(new FireBaseAuthorization()))]
  );
}

// Registration Button --> registerNewUser.dart