import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tumblrx/services/post.dart';
import 'package:tumblrx/models/text_field_data.dart';
import 'package:tumblrx/utilities/constants.dart';

void main() {
  group('Creating Post', () {
    test(
        'Index should start at Zero, Post enable at false, Text Style at normal, Post Option is Post Now, Share to Twitter at false',
        () {
      final post = Post();
      post.initializePostOptions();
      expect(post.isPostEnabled, false);
      expect(post.shareToTwitter, false);
      expect(post.lastFocusedIndex, 0);
      expect(post.chosenTextStyle, TextStyleType.Normal);
      expect(post.postOption, PostOption.now);
    });
    test('chosen blog to create post is username', () {
      final post = Post();
      post.initializePostOptions();
      post.setPostBlogUsername('username');
      expect(post.blogUsername, 'username');
    });
    test('Setting post option to draft', () {
      final post = Post();
      post.initializePostOptions();
      post.choosePostOption(PostOption.draft);
      expect(post.postOption, PostOption.draft);
    });
    test('Post Enabled should be true', () {
      final post = Post();
      post.initializePostOptions();
      post.setPostEnabled();
      expect(post.isPostEnabled, true);
    });
    test('share to Twitter should be true', () {
      final post = Post();
      post.initializePostOptions();
      post.setShareToTwitter(true);
      expect(post.shareToTwitter, true);
    });
    test('art tag should be added to chosen tags and removed from suggested',
        () {
      final post = Post();
      post.initializePostOptions();
      post.addTag('art');
      expect(post.chosenHashtags.contains('art'), true);
      expect(post.suggestedHashtags.contains('art'), false);
    });
    test('art tag should be removed', () {
      final post = Post();
      post.initializePostOptions();
      post.deleteTag('art');
      expect(post.chosenHashtags.contains('art'), false);
    });
    test('text field should be added and length of content should be 2', () {
      final post = Post();
      post.initializePostOptions();
      post.addTextField(0);
      expect(post.postContent.length, 2);
    });
    test('set text style type of last focused index textfield to normal', () {
      final post = Post();
      post.initializePostOptions();
      post.setTextStyle(TextStyleType.Normal);
      expect(
          post.postContent[post.lastFocusedIndex]['content']['data']
              .textStyleType,
          TextStyleType.Normal);
    });
    test('Color of text field in index 0 should be red', () {
      final post = Post();
      post.initializePostOptions();
      post.setTextColor(0, Colors.red);
      expect(post.postContent[0]['content']['data'].color, Colors.red);
    });
    test('text field in index 0 should be bold', () {
      final post = Post();
      post.initializePostOptions();
      post.setBold(0);
      expect(post.postContent[0]['content']['data'].isBold, true);
    });
    test('text field in index 0 should be italic', () {
      final post = Post();
      post.initializePostOptions();
      post.setItalic(0);
      expect(post.postContent[0]['content']['data'].isItalic, true);
    });
    test('text field in index 0 should be linethrough', () {
      final post = Post();
      post.initializePostOptions();
      post.setLineThrough(0);
      expect(post.postContent[0]['content']['data'].isLineThrough, true);
    });
    test('link http://www.facebook.com should be valid', () async {
      final post = Post();
      post.initializePostOptions();
      final isValid = await post.isLinkValid('http://www.facebook.com');
      expect(isValid, true);
    });
    test('link www.facebook.com should be valid', () async {
      final post = Post();
      post.initializePostOptions();
      final isValid = await post.isLinkValid('www.facebook.com');
      expect(isValid, true);
    });
    test('link facebook should not be valid', () async {
      final post = Post();
      post.initializePostOptions();
      final isValid = await post.isLinkValid('facebook');
      expect(isValid, false);
    });
  });
}
