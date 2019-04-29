import 'package:flutter/material.dart';


// Background Picture Wrapper
//
//
class BaseBackground extends StatelessWidget{
  final Widget toRecieveBackground;
  final String assetPath;

  BaseBackground( this.assetPath, this.toRecieveBackground,);

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

// Text Fields - 
//
//
class HumCustomTextField extends StatelessWidget {
  final FormField _formField;

  HumCustomTextField(this._formField);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(bottom: 6.0), child: _formField);
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

// Check Boxes / Dropdown Boxes
// 
//
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

/// Common App Button
///
///
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
    return _buildButtton(context);
  }

  Widget _buildButtton(BuildContext context) {
  return Container(

      alignment: _alignment,
      
      child: MaterialButton(

        onPressed: this._buttonType == AppButtonType.NAVIGATION ?
        () => {Navigator.push(context, MaterialPageRoute( builder: (context) => _navigationPageRoute))}
        :_functionPass,

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

