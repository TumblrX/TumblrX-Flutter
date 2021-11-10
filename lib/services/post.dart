import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/utilities/constants.dart';

class Post extends ChangeNotifier {
  bool isPostEnabled;
  bool shareToTwitter;
  PostOption postOption;
  List<String> chosenHashtags;
  List<String> suggestedHashtags;

  void initializePostOptions() {
    isPostEnabled = false;
    shareToTwitter = false;
    postOption = PostOption.now;
    notifyListeners();
  }

  void choosePostOption(PostOption option) {
    postOption = option;
    notifyListeners();
  }

  void setPostEnabled() {
    isPostEnabled = !isPostEnabled;
    notifyListeners();
  }

  void setShareToTwitter(bool value) {
    shareToTwitter = value;
    notifyListeners();
  }
}
