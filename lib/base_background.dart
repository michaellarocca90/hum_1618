import 'package:flutter/material.dart';

class BaseBackground extends StatelessWidget{
  final Widget toRecieveBackground;
  final String assetPath;

  BaseBackground(this.toRecieveBackground, this.assetPath);

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      body: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage(assetPath),
            fit: BoxFit.cover,
          ),
        ),
        child: toRecieveBackground,
      ),
    );
  }
}