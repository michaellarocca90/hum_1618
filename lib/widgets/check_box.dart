import 'package:flutter/material.dart';



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
