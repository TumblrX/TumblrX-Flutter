import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:giphy_get/giphy_get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/global.dart';
import 'package:tumblrx/models/creatingpost/text_field_data.dart';
import 'package:tumblrx/models/posts/inline_formatting.dart';
import 'package:tumblrx/models/posts/post.dart';
import 'package:tumblrx/models/posts/text_block.dart';
import 'package:tumblrx/models/user/user.dart';
import 'package:tumblrx/services/api_provider.dart';
import 'package:tumblrx/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:tumblrx/utilities/hex_color_value.dart';
import 'package:http_parser/http_parser.dart';
import 'authentication.dart';

///A Class that manages all creating post functionalities and prepare data for back end
class CreatingPost extends ChangeNotifier {
  ///boolean value if the post is reblog
  bool isReblog;

  ///boolean value if the post is edit
  bool isEdit;

  ///followed tags of the current user
  List<String> followedHashtags;

  ///chosen blog username for the post
  String blogUsername;

  ///determines if posting is allowed
  bool isPostEnabled;

  ///determines whether to share the post to twitter
  bool shareToTwitter;

  ///the chosen post option(Now, Draft or Private)
  PostOption postOption;

  ///Chosen tags for the post.
  List<String> chosenHashtags;

  ///Suggested tags that changes between followed tags and updates on user input
  List<String> suggestedHashtags;

  ///List of all post content elements
  List<dynamic> postContent;

  ///The current chosen Text Style
  TextStyleType chosenTextStyle;

  ///The index of the text field that has focus
  int lastFocusedIndex;

  ///The Image Picker class that uploads/takes pictures or videos.
  ImagePicker _picker;

  ///postID if it is editing post
  String _editPostId;

  ///Initializes all post options and variables.
  void initializePostOptions(BuildContext context,
      {bool reblog = false,
      bool edit = false,
      Post rebloggedPost,
      List<Map<String, dynamic>> editPostContent,
      String editPostId,
      List<String> editPostTags}) {
    isReblog = reblog;
    isEdit = edit;
    _editPostId = editPostId;
    lastFocusedIndex = reblog ? 1 : 0;
    isPostEnabled = false;
    shareToTwitter = false;
    postOption = PostOption.published;
    chosenHashtags = [];
    followedHashtags = [
      'art',
      'design',
      'animals',
      'football',
      'health',
      'music',
      'poetry',
      'movies',
      'entertainment',
      'cats',
      'memories'
    ];
    suggestedHashtags = [
      'art',
      'design',
      'animals',
      'football',
      'health',
      'music',
      'poetry',
      'movies',
      'entertainment',
      'cats',
      'memories'
    ];
    chosenTextStyle = TextStyleType.Normal;
    postContent = [];
    if (!isEdit)
      postContent.add({
        'type': PostContentType.text,
        'content': {
          'data': TextFieldData(chosenTextStyle),
        }
      });

    if (isReblog) {
      postContent.insert(
        0,
        {
          'type': 'PostReblog',
          'content': {
            'data': rebloggedPost,
          }
        },
      );
      setIsEnabled();
    }
    if (!isEdit) _changeFocus(isReblog ? 1 : 0);
    _picker = ImagePicker();
    if (isEdit) {
      _mapEditPostContent(editPostContent);
      if (editPostTags != null) chosenHashtags = editPostTags;
      addTextField(postContent.length - 1);
    }
    notifyListeners();
  }

  ///Maps the json data in the back-end of a post to the used form in creating post
  void _mapEditPostContent(List<Map<String, dynamic>> editedPostContent) {
    for (Map<String, dynamic> contentBlock in editedPostContent) {
      if (contentBlock['type'] == 'text') {
        TextStyleType textType = TextStyleType.Normal;
        if (contentBlock.containsKey('subtype')) {
          textType = kTextSubtypeMap[contentBlock['subtype']];
        }
        TextFieldData textFieldData = TextFieldData(textType);
        textFieldData.addText(contentBlock['text']);
        postContent.add({
          'type': PostContentType.text,
          'content': {
            'data': textFieldData,
          }
        });
      } else if (contentBlock['type'] == 'link') {
        postContent.add({
          'type': PostContentType.link,
          'content': {
            'link': contentBlock['url'],
          }
        });
      } else if (contentBlock['type'] == 'image' &&
          contentBlock['media'] == 'image/gif') {
        postContent.add({
          'type': PostContentType.gif,
          'content': {
            'link': contentBlock['url'],
          }
        });
      } else if (contentBlock['type'] == 'image') {
        postContent.add({
          'type': PostContentType.image,
          'content': {
            'data': {'url': contentBlock['url']},
          }
        });
      } else if (contentBlock['type'] == 'video') {
        postContent.add({
          'type': PostContentType.video,
          'content': {
            'data': {'url': contentBlock['url']},
          }
        });
      }
    }
  }

  ///sets the [option] of the post whether it's (Post Now(Published), Private, Draft)
  void choosePostOption(PostOption option) {
    postOption = option;
    notifyListeners();
  }

  ///Toggles if the post ie enabled
  void setPostEnabled() {
    isPostEnabled = !isPostEnabled;
    notifyListeners();
  }

  ///sets the boolean [value] of whether the post is shared to twitter
  void setShareToTwitter(bool value) {
    shareToTwitter = value;
    notifyListeners();
  }

  ///Takes a new [tag] value and adds it the [chosenHashtags] list and removes it from [suggestedHashtags] list
  void addTag(String tag) {
    chosenHashtags.add(tag);
    suggestedHashtags.remove(tag);
    notifyListeners();
  }

  ///removes a [tag] from the [chosenHashtags] list.
  ///It adds it back to [suggestedHashtags] list if it was in [followedHashtags]
  void deleteTag(String tag) {
    chosenHashtags.remove(tag);
    notifyListeners();
    if (followedHashtags.contains(tag)) suggestedHashtags.add(tag);
  }

  ///Takes user input [tag] and searches in [followedHashtags] to suggest all possible tags.
  void searchSuggestedTags(String tag) {
    suggestedHashtags = [];
    for (String followedTag in followedHashtags) {
      if (followedTag.contains(RegExp(tag, caseSensitive: false)))
        suggestedHashtags.add(followedTag);
    }
    notifyListeners();
  }

  ///Adds a new text field after the position of the [currentIndex]
  ///It sets it with the last [chosenTextStyle] and have it focused.
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

  ///Changes focus of a text field with this [index]
  void _changeFocus(int index) {
    postContent[index]['content']['data'].focusNode.requestFocus();
  }

  ///deletes the text field of the sent [index]
  ///It doesn't delete it if it has index 0
  void removeTextField(int index) {
    int firstTextFieldIndex = isReblog ? 1 : 0;
    if (index != firstTextFieldIndex &&
        postContent[index - 1]['type'] == PostContentType.text) {
      postContent.removeAt(index);
      _changeFocus(index - 1);
      notifyListeners();
    }
  }

  ///deletes a post content item of the sent [index]
  void removePostItem(int index) {
    postContent.removeAt(index);
    checkPostEnable();
    notifyListeners();
  }

  ///switches to the next text style in the [TextStyleType] enum
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

  ///Saves the index of the text field that has focus currently
  void saveFocusedIndex() {
    for (int i = 0; i < postContent.length; i++) {
      if (postContent[i]['type'] == PostContentType.text &&
          postContent[i]['content']['data'].focusNode.hasFocus) {
        lastFocusedIndex = i;
        break;
      }
    }
  }

  ///sets the text field of [lastFocusedIndex] with the Text Style [type]
  void setTextStyle(TextStyleType type) {
    chosenTextStyle = type;
    postContent[lastFocusedIndex]['content']['data'].focusNode.requestFocus();
    postContent[lastFocusedIndex]['content']['data']
        .setTextStyleType(chosenTextStyle);
    notifyListeners();
  }

  ///Changes the [color] of text field of chosen [index]
  void setTextColor(int index, Color color) {
    postContent[index]['content']['data'].color = color;
    postContent[index]['content']['data'].updateTextStyle();
    notifyListeners();
  }

  ///Toggles bold style of a text field of chosen [index]
  void setBold(int index) {
    postContent[index]['content']['data'].isBold =
        !postContent[index]['content']['data'].isBold;
    postContent[index]['content']['data'].updateTextStyle();
    notifyListeners();
  }

  ///Toggles italic style of a text field of chosen [index]
  void setItalic(int index) {
    postContent[index]['content']['data'].isItalic =
        !postContent[index]['content']['data'].isItalic;
    postContent[index]['content']['data'].updateTextStyle();
    notifyListeners();
  }

  ///Toggles lineThrough style of a text field of chosen [index]
  void setLineThrough(int index) {
    postContent[index]['content']['data'].isLineThrough =
        !postContent[index]['content']['data'].isLineThrough;
    postContent[index]['content']['data'].updateTextStyle();
    notifyListeners();
  }

  ///It shows GIF Search Bottom Sheet in current [context] from GIPHY and adds it if a GIF was chosen.
  ///it is added after the position of [lastFocusedIndex]
  void addGif(BuildContext context) async {
    saveFocusedIndex();
    GiphyGif gif = await GiphyGet.getGif(
      modal: false,
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

  ///Allow the post to be added
  void setIsEnabled() {
    isPostEnabled = true;
    notifyListeners();
  }

  ///Checks if the post is allowed by checking if it has elements other than text fields or non empty text fields
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

  ///Checks if a [link] is valid and adds http:// before it if there wasn't
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

  ///Adds a [link] preview to the post after the position of [lastFocusedIndex]
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

  ///Adds image to the post from gallery or from camera if [isCamera] is true.
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

  ///Adds video to the post from gallery or from camera if [isCamera] is true.
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

  ///It retrieves lost cached images or videos
  Future<XFile> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty || response.file == null) {
      return null;
    }
    return response.file;
  }

  ///It maps the collected data about the post to the final form and send it in a post request.
  Future<bool> postData(BuildContext context) async {
    List<Map> files = [];
    Map<String, dynamic> requestBody = isEdit
        ? {}
        : {
            'blog': Provider.of<User>(context, listen: false).getActiveBlogId(),
            'postType': 'text',
            'tags': _formatTags(),
            'state': postOption.toString().substring(11),
            'send_to_twitter': shareToTwitter,
            'blogAttribution': {
              'blogTitle': Provider.of<User>(context, listen: false)
                  .getActiveBlogTitle(),
            }
          };

    List<Map> postContentList = [];
    for (int i = 0; i < postContent.length; i++) {
      if (postContent[i]['type'] == PostContentType.text) {
        int textLength = postContent[i]['content']['data']
            .textEditingController
            .value
            .text
            .length;
        if (textLength > 0) postContentList.add(_getTextBlockMap(i));
      } else if (postContent[i]['type'] == 'PostReblog') {
        requestBody =
            _addReblogBody(requestBody, postContent[i]['content']['data'].id);
      } else if (postContent[i]['type'] == PostContentType.gif) {
        postContentList.add(_getGifBlockMap(i));
      } else if (postContent[i]['type'] == PostContentType.link) {
        postContentList.add(_getLinkBlockMap(i));
      } else if (postContent[i]['type'] == PostContentType.image) {
        Map map = _getImageBlockMap(i);
        if (map.containsKey('identifier')) {
          files.add({
            'identifier': map['identifier'],
            'path': postContent[i]['content'].path,
            'filename': postContent[i]['content'].name,
            'contentType': MediaType("image", "jpeg")
          });

          requestBody[map['identifier']] = await MultipartFile.fromFile(
            postContent[i]['content'].path,
            filename: postContent[i]['content'].name,
            contentType: MediaType("image", "jpeg"),
          );
        }
        postContentList.add(map);
      } else if (postContent[i]['type'] == PostContentType.video) {
        Map map = _getVideoBlockMap(i);
        if (map.containsKey('identifier')) {
          files.add({
            'identifier': map['identifier'],
            'path': postContent[i]['content'].path,
            'filename': postContent[i]['content'].name,
            'contentType': MediaType("video", "mp4")
          });
          requestBody[map['identifier']] = await MultipartFile.fromFile(
            postContent[i]['content'].path,
            filename: postContent[i]['content'].name,
            contentType: MediaType("video", "mp4"),
          );
        }
        postContentList.add(map);
      }
    }
    requestBody['content'] = postContentList;

    try {
      var body = FormData.fromMap(requestBody);
      logger.d(requestBody);
      var dio = Dio();
      //dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers["authorization"] =
          Provider.of<Authentication>(context, listen: false).token;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: kPrimaryColor,
          content: Text('Processing the media for your post...'),
        ),
      );

      String createPostEndPoint = 'api/blog/' +
          Provider.of<User>(context, listen: false).getActiveBlogId() +
          '/posts';
      String editPostEndPoint;
      if (_editPostId != null) editPostEndPoint = 'api/post/' + _editPostId;
      var response;
      if (isEdit) {
        response = await dio.put(
          ApiHttpRepository.api + editPostEndPoint,
          data: body,
          onSendProgress: (int sent, int total) {
            logger.d('$sent $total');
          },
        );
      } else {
        response = await dio.post(
          ApiHttpRepository.api + createPostEndPoint,
          data: body,
          onSendProgress: (int sent, int total) {
            logger.d('$sent $total');
          },
        );
      }

      logger.d('Response status: ${response.statusCode}');
      if (response.statusCode == 201 || response.statusCode == 200)
        return true;
      else
        return false;
    } catch (e) {
      logger.e(e);
      return false;
    }
  }

  ///Converts text data of index [i] to final map block format
  Map _getTextBlockMap(int i) {
    int textLength = postContent[i]['content']['data']
        .textEditingController
        .value
        .text
        .length;

    List<InlineFormatting> formattings = [];
    if (postContent[i]['content']['data'].isBold) {
      InlineFormatting formatting =
          InlineFormatting(start: 0, end: textLength - 1, type: 'bold');
      formattings.add(formatting);
    }
    if (postContent[i]['content']['data'].isItalic) {
      InlineFormatting formatting =
          InlineFormatting(start: 0, end: textLength - 1, type: 'italic');
      formattings.add(formatting);
    }
    if (postContent[i]['content']['data'].isLineThrough) {
      InlineFormatting formatting = InlineFormatting(
          start: 0, end: textLength - 1, type: 'strikethrough');
      formattings.add(formatting);
    }
    InlineFormatting formatting =
        InlineFormatting(start: 0, end: textLength - 1, type: 'color');
    int red = postContent[i]['content']['data'].color.red;
    int blue = postContent[i]['content']['data'].color.blue;
    int green = postContent[i]['content']['data'].color.green;
    String hexColor = getHexValue(red, blue, green);
    formatting.setHexColor(hexColor);
    formattings.add(formatting);

    TextBlock textBlock = TextBlock(
      type: "text",
      subtype: postContent[i]['content']['data']
          .textStyleType
          .toString()
          .substring(14)
          .toLowerCase(),
      text: postContent[i]['content']['data'].textEditingController.value.text,
      formatting: formattings,
    );
    Map block = textBlock.toJson();
    block = kMapTextStyleToBackend(block);
    List<InlineFormatting> formattingList = block['formatting'];
    List<Map> jsonFormatting = [];
    for (int i = 0; i < formattingList.length; i++) {
      jsonFormatting.add(formattingList[i].toJson());
    }
    block['formatting'] = jsonFormatting;

    return block;
  }

  ///Converts gif of index [i] to final map block format
  Map _getGifBlockMap(int i) {
    return {
      'type': 'image',
      'media': 'image/gif',
      'url': postContent[i]['content']['link']
    };
  }

  ///Converts link of index [i] to final map block format
  Map _getLinkBlockMap(int i) {
    return {
      'type': 'link',
      'title': postContent[i]['content']['link'],
      'url': postContent[i]['content']['link']
    };
  }

  ///Converts image of index [i] to final map block format
  Map _getImageBlockMap(int i) {
    if (postContent[i]['content'] is Map &&
        postContent[i]['content']['data'].containsKey('url'))
      return {
        'type': 'image',
        'media': 'image/jpeg',
        'url': postContent[i]['content']['data']['url']
      };
    return {'type': 'image', 'media': 'image/jpeg', 'identifier': i.toString()};
  }

  ///Converts video of index [i] to final map block format
  Map _getVideoBlockMap(int i) {
    if (postContent[i]['content'] is Map &&
        postContent[i]['content']['data'].containsKey('url')) {
      return {
        'type': 'video',
        'media': 'video/mp4',
        'url': postContent[i]['content']['data']['url']
      };
    }
    return {'type': 'video', 'media': 'video/mp4', 'identifier': i.toString()};
  }

  ///Adds reblog data to the request body
  Map<String, dynamic> _addReblogBody(Map<String, dynamic> body, String id) {
    body['reblogData'] = {};
    body['reblogData']['parentPostId'] = id;
    return body;
  }

  Map<String, String> _formatTags() {
    Map<String, String> tags = {};
    for (int i = 0; i < chosenHashtags.length; i++) {
      tags[i.toString()] = chosenHashtags[i];
    }
    return tags;
  }
}
