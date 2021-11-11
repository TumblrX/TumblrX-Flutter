import 'package:flutter/material.dart';
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
}
