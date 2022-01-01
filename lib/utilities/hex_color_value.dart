import 'dart:ui';
import 'package:flutter/material.dart';

///A function that takes integer values of [red], [blue], [green] values of a color
///and return it in a String format
///getHexValue(255,255,255) -> #ffffff
String getHexValue(int red, int blue, int green) {
  return '#' +
      red.toRadixString(16).padLeft(2, '0').toString() +
      blue.toRadixString(16).padLeft(2, '0').toString() +
      green.toRadixString(16).padLeft(2, '0').toString();
}
/// A function convert a color from hex to color
/// '#000000'->'0Xff000000'
Color hexToColor(String code) {
  if (code != null && code.length != 0)
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  return Colors.blue;
}
///convert color to hex
///'0xff000000'->'#000000'
String colorToHexString(Color color) {
  return '#${color.value.toRadixString(16).substring(2, 8)}';
}
