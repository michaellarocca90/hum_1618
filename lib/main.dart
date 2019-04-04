import 'package:flutter/material.dart';
import './splash.dart';

void main() => runApp(HumApp());

class HumApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
        title: 'Hum',
        theme: ThemeData(primarySwatch: Colors.purple),
        home: SplashPage());
  }
}
