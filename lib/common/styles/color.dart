import 'package:flutter/material.dart';
import 'package:leggo/tool/hex_color.dart';

final hWhite = HexColor("#FFFFFF");

final MaterialColor mWhite = _convertMateial(255, 255, 255);
final MaterialColor mOrange = _convertMateial(249, 115, 22);
final MaterialColor mBlack = _convertMateial(0, 0, 0);

MaterialColor _convertMateial(int red, int green, int blue) {
  Map<int, Color> _colorCodes = {
    50: Color.fromRGBO(red, green, blue, .1),
    100: Color.fromRGBO(red, green, blue, .2),
    200: Color.fromRGBO(red, green, blue, .3),
    300: Color.fromRGBO(red, green, blue, .4),
    400: Color.fromRGBO(red, green, blue, .5),
    500: Color.fromRGBO(red, green, blue, .6),
    600: Color.fromRGBO(red, green, blue, .7),
    700: Color.fromRGBO(red, green, blue, .8),
    800: Color.fromRGBO(red, green, blue, .9),
    900: Color.fromRGBO(red, green, blue, 1),
  };

  return MaterialColor(0xFF93cd48, _colorCodes);
}
