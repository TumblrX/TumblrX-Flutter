///A function that takes integer values of [red], [blue], [green] values of a color
///and return it in a String format
///getHexValue(255,255,255) -> #ffffff
String getHexValue(int red, int blue, int green) {
  return '#' +
      red.toRadixString(16).padLeft(2, '0').toString() +
      blue.toRadixString(16).padLeft(2, '0').toString() +
      green.toRadixString(16).padLeft(2, '0').toString();
}
