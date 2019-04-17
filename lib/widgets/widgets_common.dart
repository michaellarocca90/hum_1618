import 'package:flutter/material.dart';

import '../shelf.dart';

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

class HumCheckbox extends StatelessWidget {
  final String _title;
  final bool _value;
  final Function _f;
  final Text _validation;

  HumCheckbox(this._title, this._value, this._f, this._validation);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: new CheckboxListTile(
        title: Text(_title),
        value: _value,
        onChanged: (bool value) {
          _f(value);
        },
        subtitle: _validation,
      ),
    );
  }
}

class HumCustomTextField extends StatelessWidget {
  final FormField _formField;

  HumCustomTextField(this._formField);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(bottom: 6.0), child: _formField);
  }
}

class HumDropdown extends StatelessWidget {
  final String _label;
  final List<String> _items;
  final String _value;
  final Function _f;

  HumDropdown(this._label, this._items, this._value, this._f);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 6.0,
      ),
      child: new DropdownButtonFormField(
          validator: (value) {
            if (value == null) {
              return "Please select a value";
            }
          },
          decoration: new InputDecoration(
              labelText: _label,
              fillColor: Colors.white.withOpacity(.25),
              filled: true,
              border: OutlineInputBorder()),
          items: _items.map((String i) {
            return new DropdownMenuItem(child: Text(i), value: i);
          }).toList(),
          onChanged: (newValue) {
            _f(newValue);
          },
          value: _value),
    );
  }
}

class HumTextField extends StatelessWidget {
  final String _label;
  final TextEditingController _controller;

  HumTextField(this._label, this._controller);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(bottom: 6.0),
        child: new TextFormField(
          controller: _controller,
          validator: (value) {
            if (value.isEmpty) {
              return "Field `$_label` cannot be blank";
            }
          },
          decoration: new InputDecoration(
              labelText: _label,
              fillColor: Colors.white.withOpacity(.25),
              filled: true,
              border: OutlineInputBorder()),
        ));
  }
}




enum AppButtonType {NAVIGATION, FUNCTION}

class CommonAppButtons extends StatelessWidget{

  final AppButtonType _buttonType;
  final String _displayText;
  final Alignment _alignment;
  final Object _pageRoute;
  final BorderRadius _borderRadius;
  final TextStyle _textStyle;



  CommonAppButtons(
    this._buttonType,
    this._displayText, 
    this._alignment, 
    this._pageRoute,
    this._borderRadius,
    this._textStyle);

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

  Widget _commonNavigationButton(BuildContext context) {
  return Container(
      alignment: _alignment,
      child: MaterialButton(

        onPressed: () => {Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => _pageRoute
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
    Widget _commonFucntionButton(BuildContext context) {
  return Container(
      alignment: _alignment,
      child: MaterialButton(

        onPressed: () => _pageRoute,

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