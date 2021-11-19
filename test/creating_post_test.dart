import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/models/user/account.dart';
import 'package:tumblrx/services/creating_post.dart';
import 'package:tumblrx/utilities/constants.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  final post = CreatingPost();
  BuildContext context = MockBuildContext();
  group('Creating Post', () {
    test(
        'Index should start at Zero, Post enable at false, Text Style at normal, Post Option is Post Now, Share to Twitter at false',
        () {
      post.initializePostOptions(context);
      expect(post.isPostEnabled, false);
      expect(post.shareToTwitter, false);
      expect(post.lastFocusedIndex, 0);
      expect(post.chosenTextStyle, TextStyleType.Normal);
      expect(post.postOption, PostOption.now);
    });

    test('Setting post option to draft', () {
      final post = CreatingPost();
      post.initializePostOptions(context);
      post.choosePostOption(PostOption.draft);
      expect(post.postOption, PostOption.draft);
    });
    test('Post Enabled should be true', () {
      final post = CreatingPost();
      post.initializePostOptions(context);
      post.setPostEnabled();
      expect(post.isPostEnabled, true);
    });
    test('share to Twitter should be true', () {
      final post = CreatingPost();
      post.initializePostOptions(context);
      post.setShareToTwitter(true);
      expect(post.shareToTwitter, true);
    });
    test('art tag should be added to chosen tags and removed from suggested',
        () {
      final post = CreatingPost();
      post.initializePostOptions(context);
      post.addTag('art');
      expect(post.chosenHashtags.contains('art'), true);
      expect(post.suggestedHashtags.contains('art'), false);
    });
    test('art tag should be removed', () {
      final post = CreatingPost();
      post.initializePostOptions(context);
      post.deleteTag('art');
      expect(post.chosenHashtags.contains('art'), false);
    });
    test('text field should be added and length of content should be 2', () {
      final post = CreatingPost();
      post.initializePostOptions(context);
      post.addTextField(0);
      expect(post.postContent.length, 2);
    });
    test('set text style type of last focused index textfield to normal', () {
      final post = CreatingPost();
      post.initializePostOptions(context);
      post.setTextStyle(TextStyleType.Normal);
      expect(
          post.postContent[post.lastFocusedIndex]['content']['data']
              .textStyleType,
          TextStyleType.Normal);
    });
    test('Color of text field in index 0 should be red', () {
      final post = CreatingPost();
      post.initializePostOptions(context);
      post.setTextColor(0, Colors.red);
      expect(post.postContent[0]['content']['data'].color, Colors.red);
    });
    test('text field in index 0 should be bold', () {
      final post = CreatingPost();
      post.initializePostOptions(context);
      post.setBold(0);
      expect(post.postContent[0]['content']['data'].isBold, true);
    });
    test('text field in index 0 should be italic', () {
      final post = CreatingPost();
      post.initializePostOptions(context);
      post.setItalic(0);
      expect(post.postContent[0]['content']['data'].isItalic, true);
    });
    test('text field in index 0 should be linethrough', () {
      final post = CreatingPost();
      post.initializePostOptions(context);
      post.setLineThrough(0);
      expect(post.postContent[0]['content']['data'].isLineThrough, true);
    });
    test('link http://www.facebook.com should be valid', () async {
      final post = CreatingPost();
      post.initializePostOptions(context);
      final isValid = await post.isLinkValid('http://www.facebook.com');
      expect(isValid, true);
    });
    test('link www.facebook.com should be valid', () async {
      final post = CreatingPost();
      post.initializePostOptions(context);
      final isValid = await post.isLinkValid('www.facebook.com');
      expect(isValid, true);
    });
    test('link facebook should not be valid', () async {
      final post = CreatingPost();
      post.initializePostOptions(context);
      final isValid = await post.isLinkValid('facebook');
      expect(isValid, false);
    });
  });
}
