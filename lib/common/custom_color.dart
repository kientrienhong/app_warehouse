import 'package:flutter/material.dart';

class CustomColor {
  static const _blackMonoValue = 0xFF130F26;

  static const MaterialColor black =
      MaterialColor(_blackMonoValue, <int, Color>{
    0: Color(_blackMonoValue),
    2: Color(0xFF423F51),
    1: Color(0xFF716F7D),
    3: Color(0xFFA19FA8),
  });

  static const _bluePrimaryValue = 0xFFF335BFF;
  static const MaterialColor blue = MaterialColor(
      _bluePrimaryValue, <int, Color>{0: Color(_bluePrimaryValue)});

  static const _purplePrimaryValue = 0xFF8099FF;
  static const MaterialColor purple = MaterialColor(
      _purplePrimaryValue, <int, Color>{0: Color(_purplePrimaryValue)});

  static const _lightBluePrimaryValue = 0xFFE5EBFF;
  static const MaterialColor lightBlue = MaterialColor(
      _lightBluePrimaryValue, <int, Color>{0: Color(_lightBluePrimaryValue)});

  static const _brightBluePrimaryValue = 0xFFC6F8FF;
  static const MaterialColor brightBlue = MaterialColor(
      _brightBluePrimaryValue, <int, Color>{0: Color(_brightBluePrimaryValue)});

  static const _redSemantic = 0xFFCE0200;
  static const MaterialColor pink =
      MaterialColor(_redSemantic, <int, Color>{0: Color(_redSemantic)});

  static const _greenSemantic = 0xFF00993C;
  static const MaterialColor green =
      MaterialColor(_greenSemantic, <int, Color>{0: Color(_greenSemantic)});

  static const _white = 0xFFFFFFFFF;
  static const MaterialColor white =
      MaterialColor(_white, <int, Color>{0: Color(_white)});

  static const _gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF595CFF), Color(0xFFC6F8FF)]);

  static LinearGradient get gradientColor {
    return _gradient;
  }
}