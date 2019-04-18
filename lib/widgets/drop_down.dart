import 'package:flutter/material.dart';

//import '../shelf.dart';

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

