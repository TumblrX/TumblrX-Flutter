import 'package:flutter/material.dart';

String getHexValue(int red, int blue, int green) {
  return '#' +
      red.toRadixString(16).padLeft(2, '0').toString() +
      blue.toRadixString(16).padLeft(2, '0').toString() +
      green.toRadixString(16).padLeft(2, '0').toString();
}
