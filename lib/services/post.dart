import 'package:flutter/material.dart';
import 'package:giphy_get/giphy_get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tumblrx/models/text_field_data.dart';
import 'package:tumblrx/utilities/constants.dart';
import 'package:http/http.dart' as http;

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
  List<dynamic> postContent;
  TextStyleType chosenTextStyle;
  int lastFocusedIndex;
  ImagePicker _picker;

  void initializePostOptions() {
    lastFocusedIndex = 0;
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
    postContent = [
      {
        'type': PostContentType.text,
        'content': {
          'data': TextFieldData(chosenTextStyle),
        }
      },
    ];
    _changeFocus(0);
    _picker = ImagePicker();
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
    dynamic textField = {
      'type': PostContentType.text,
      'content': {
        'data': TextFieldData(chosenTextStyle),
      }
    };
    postContent.insert(currentIndex + 1, textField);
    _changeFocus(currentIndex + 1);
    notifyListeners();
  }

  void _changeFocus(int index) {
    postContent[index]['content']['data'].focusNode.requestFocus();
  }

  void removeTextField(int index) {
    if (index != 0 && postContent[index - 1]['type'] == PostContentType.text) {
      postContent.removeAt(index);
      _changeFocus(index - 1);
      notifyListeners();
    }
  }

  void removePostItem(int index) {
    postContent.removeAt(index);
    notifyListeners();
  }

  void nextTextStyle([int index = -1]) {
    chosenTextStyle = TextStyleType.values[(chosenTextStyle.index + 1) % 6];
    if (index != -1) {
      postContent[index]['content']['data'].setTextStyleType(chosenTextStyle);
    } else {
      for (int i = 0; i < postContent.length; i++) {
        if (postContent[i]['type'] == PostContentType.text &&
            postContent[i]['content']['data'].focusNode.hasFocus) {
          postContent[i]['content']['data'].setTextStyleType(chosenTextStyle);
          break;
        }
      }
    }
    notifyListeners();
  }

  void saveFocusedIndex() {
    for (int i = 0; i < postContent.length; i++) {
      if (postContent[i]['type'] == PostContentType.text &&
          postContent[i]['content']['data'].focusNode.hasFocus) {
        lastFocusedIndex = i;
        break;
      }
    }
  }

  void setTextStyle(TextStyleType type) {
    chosenTextStyle = type;
    postContent[lastFocusedIndex]['content']['data'].focusNode.requestFocus();
    postContent[lastFocusedIndex]['content']['data']
        .setTextStyleType(chosenTextStyle);
    notifyListeners();
  }

  void setTextColor(int index, Color color) {
    postContent[index]['content']['data'].color = color;
    postContent[index]['content']['data'].updateTextStyle();
    notifyListeners();
  }

  void setBold(int index) {
    postContent[index]['content']['data'].isBold =
        !postContent[index]['content']['data'].isBold;
    postContent[index]['content']['data'].updateTextStyle();
    notifyListeners();
  }

  void setItalic(int index) {
    postContent[index]['content']['data'].isItalic =
        !postContent[index]['content']['data'].isItalic;
    postContent[index]['content']['data'].updateTextStyle();
    notifyListeners();
  }

  void setLineThrough(int index) {
    postContent[index]['content']['data'].isLineThrough =
        !postContent[index]['content']['data'].isLineThrough;
    postContent[index]['content']['data'].updateTextStyle();
    notifyListeners();
  }

  void addGif(BuildContext context) async {
    saveFocusedIndex();
    GiphyGif gif = await GiphyGet.getGif(
      context: context,
      apiKey: 'N4xaE80Z4B2vOJ5Kd6VAKsmYqXx4Ijyq',
    );
    if (gif != null) {
      dynamic pickedGif = {
        'type': PostContentType.gif,
        'content': {'link': gif.images.original.webp}
      };
      postContent.insert(lastFocusedIndex + 1, pickedGif);
      addTextField(lastFocusedIndex + 1);
      setIsEnabled();
    } else
      return;
  }

  void setIsEnabled() {
    isPostEnabled = true;
    notifyListeners();
  }

  void checkPostEnable() {
    for (int i = 0; i < postContent.length; i++) {
      if (postContent[i]['type'] != PostContentType.text) {
        setIsEnabled();
        return;
      } else {
        if (postContent[i]['content']['data']
                .textEditingController
                .value
                .text
                .length >
            0) {
          setIsEnabled();
          return;
        }
      }
    }
    isPostEnabled = false;
    notifyListeners();
  }

  Future<bool> isLinkValid(String link) async {
    if (link.substring(0, 4) != "http") link = "http://" + link;
    try {
      final response = await http.get(Uri.parse(link), headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
      });
      if (response.statusCode == 200) return true;
    } catch (error) {
      return false;
    }
    return false;
  }

  void addLinkPreview(String link) {
    if (link.substring(0, 4) != "http") link = "http://" + link;
    dynamic linkMap = {
      'type': PostContentType.link,
      'content': {'link': link}
    };
    postContent.insert(lastFocusedIndex + 1, linkMap);
    addTextField(lastFocusedIndex + 1);
    setIsEnabled();
  }

  void addImage({bool isCamera}) async {
    final XFile image = await _picker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery);
    if (image != null) {
      Map img = {'type': PostContentType.image, 'content': image};
      postContent.insert(lastFocusedIndex + 1, img);
      addTextField(lastFocusedIndex + 1);
      setIsEnabled();
    }
  }

  void addVideo({bool isCamera}) async {
    final XFile video = await _picker.pickVideo(
        source: isCamera ? ImageSource.camera : ImageSource.gallery);
    if (video != null) {
      Map vid = {'type': PostContentType.video, 'content': video};
      postContent.insert(lastFocusedIndex + 1, vid);
      addTextField(lastFocusedIndex + 1);
      setIsEnabled();
    }
  }

  Future<XFile> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty || response.file == null) {
      return null;
    }
    return response.file;
  }
}
