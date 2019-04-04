import 'package:flutter/material.dart';
import 'base_background.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseBackground(_splashButtons(), "assets/hum_shake_logo.jpg");
  }
}

Widget _splashButtons() {
  return Stack(children: <Widget>[_registerButton(), _signInButton()],);
}

// this can be refactored to a single function that takes an alignment property
Widget _registerButton(){
  return Container(
      alignment: Alignment(-0.75, -0.5),
      child: MaterialButton(
        onPressed: () => {},
        child: new Text(
          'Register',
          style: new TextStyle(
            fontSize: 17.5, 
          ),
        ),
        color: Colors.purple,
        splashColor: Colors.purpleAccent,
        textColor: Colors.white,
      ));
}

Widget _signInButton(){
  return Container(
      alignment: Alignment(0.75, -0.5),
      child: MaterialButton(
        onPressed: () => {},
        child: new Text(
          'Sign-in',
          style: new TextStyle(
            fontSize: 17.5, 
          ),
        ),
        color: Colors.purple,
        splashColor: Colors.purpleAccent,
        textColor: Colors.white,
      ));
}