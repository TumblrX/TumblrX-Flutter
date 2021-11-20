import 'package:flutter/material.dart';

class BlogScreenConstantProvider extends ChangeNotifier {
  Color bottomCoverColor;

  void initialization() {
    bottomCoverColor = Color(0xffb03fa8);
    notifyListeners();
  }

  void setBottomColor(Color bottomColor) {
    bottomCoverColor = bottomColor;
    notifyListeners();
  }

  Color getBottomColor() {
    return bottomCoverColor;
  }
}
