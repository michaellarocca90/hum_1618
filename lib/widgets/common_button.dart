import 'package:flutter/material.dart';

//import '../shelf.dart';

enum AppButtonType {NAVIGATION, FUNCTION}

class CommonAppButtons extends StatelessWidget{

  final AppButtonType _buttonType;
  final String _displayText;
  final Alignment _alignment;
  final BorderRadius _borderRadius;
  final TextStyle _textStyle;


  final VoidCallback _functionPass;
  final Object _navigationPageRoute;


  CommonAppButtons.function(
    this._buttonType,
    this._displayText,
    this._alignment,
    this._borderRadius,
    this._textStyle,
    this._functionPass
    ):
    this._navigationPageRoute = null;
  
  CommonAppButtons.navigation(
    this._buttonType,
    this._displayText,
    this._alignment,
    this._borderRadius,
    this._textStyle,
    this._navigationPageRoute
  ):
  this._functionPass = null;


  Widget build(BuildContext context) {

    switch (_buttonType){

      case AppButtonType.FUNCTION:
      return _commonFucntionButton(context);
      break;

      case AppButtonType.NAVIGATION:
      return _commonNavigationButton(context);
      break;
    }
    
  }

  
    Widget _commonFucntionButton(BuildContext context) {
  return Container(
      alignment: _alignment,
      child: MaterialButton(

        onPressed: _functionPass,

        shape: new RoundedRectangleBorder(
            borderRadius: _borderRadius),
        
        child: new Text(
          _displayText,
          style:
          _textStyle,
        ),
        color: Colors.white,
        splashColor: Colors.purpleAccent,
        textColor: Colors.purple,
      ));
  }

  Widget _commonNavigationButton(BuildContext context) {
  return Container(
      alignment: _alignment,
      child: MaterialButton(

        onPressed: () => {Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => _navigationPageRoute
                      ))},

        shape: new RoundedRectangleBorder(
            borderRadius: _borderRadius),
        
        child: new Text(
          _displayText,
          style:
          _textStyle,
        ),
        color: Colors.white,
        splashColor: Colors.purpleAccent,
        textColor: Colors.purple,
      ));
  }



}