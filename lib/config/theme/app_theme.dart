import 'package:flutter/material.dart';

const Color _customColor = Color.fromARGB(0, 6, 6, 88);

const List<Color> _colorThemes = [
_customColor,
Colors.blue,
Colors.teal,
Colors.green,
Colors.yellow,
Colors.pink,
Colors.orange,
Colors.red,
];


class AppTheme{

  final int selectedColor;

  AppTheme({
    this.selectedColor = 0
    }): assert(selectedColor >= 0 && selectedColor <= _colorThemes.length -1,'Colors must be between 0 and ${_colorThemes.length}');

  ThemeData theme(){
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: _colorThemes[selectedColor]
    );
  }

}