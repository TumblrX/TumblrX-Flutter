import 'package:flutter/material.dart';
import 'package:tumblrx/models/text_field_data.dart';
import 'package:tumblrx/utilities/constants.dart';

class Post extends ChangeNotifier {
  List<String> followedHashtags;
  List<String> blogUsernames;
  Map<String, String> blogUsernamesTitles;
  String blogUsername;
  String blogTitle;
  bool isPostEnabled;
  bool shareToTwitter;
  PostOption postOption;
  List<String> chosenHashtags;
  List<String> suggestedHashtags;
  List<TextFieldData> textFieldData;
  Map<int, Widget> otherPostContent;
  TextStyleType chosenTextStyle;

  void initializePostOptions() {
    blogUsernames = ['ammarovic21', 'ammmar', 'ammaar'];
    blogUsernamesTitles = {
      'ammarovic21': 'title1',
      'ammmar': 'title2',
      'ammaar': 'title3'
    };
    blogUsername = 'ammarovic21';
    blogTitle = 'title1';
    isPostEnabled = false;
    shareToTwitter = false;
    postOption = PostOption.now;
    chosenHashtags = [];
    followedHashtags = [
      'art',
      'design',
      'animals',
      'football',
      'health',
      'music',
      'poetry'
    ];
    suggestedHashtags = [
      'art',
      'design',
      'animals',
      'football',
      'health',
      'music',
      'poetry'
    ];
    chosenTextStyle = TextStyleType.Normal;
    textFieldData = [TextFieldData(chosenTextStyle)];
    _changeFocus(0);
    notifyListeners();
  }

  void setPostBlogUsername(String username) {
    blogUsername = username;
    blogTitle = blogUsernamesTitles[username];
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

  void addTag(String tag) {
    chosenHashtags.add(tag);
    suggestedHashtags.remove(tag);
    notifyListeners();
  }

  void deleteTag(String tag) {
    chosenHashtags.remove(tag);
    notifyListeners();
    if (followedHashtags.contains(tag)) suggestedHashtags.add(tag);
  }

  void searchSuggestedTags(String tag) {
    suggestedHashtags = [];
    for (String followedTag in followedHashtags) {
      if (followedTag.contains(RegExp(tag, caseSensitive: false)))
        suggestedHashtags.add(followedTag);
    }
    notifyListeners();
  }

  void addTextField(int currentIndex) {
    textFieldData.insert(currentIndex + 1, TextFieldData(chosenTextStyle));
    _changeFocus(currentIndex + 1);
    notifyListeners();
  }

  void _changeFocus(int index) {
    textFieldData[index].focusNode.requestFocus();
  }

  void removeTextField(int index) {
    textFieldData.removeAt(index);
    _changeFocus(index - 1);
    notifyListeners();
  }

  void nextTextStyle() {
    chosenTextStyle = TextStyleType.values[(chosenTextStyle.index + 1) % 6];
    for (int i = 0; i < textFieldData.length; i++) {
      if (textFieldData[i].focusNode.hasFocus) {
        textFieldData[i].setTextStyleType(chosenTextStyle);
        break;
      }
    }
    notifyListeners();
  }
}
