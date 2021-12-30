/*
Author: Passant Abdelgalil
Description: 
    A class to build an object to store notes data to be used later
*/

import 'package:tumblrx/global.dart';
import 'package:tumblrx/models/user/blog.dart';

class Notes {
  String _postId;
  String _type;
  Blog _blogData;
  String _commentText;

  String get postId => _postId;
  String get type => _type;
  Blog get blogData => _blogData;
  String get commentText => _commentText;

  Notes.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('rebloggedPostId')) _postId = json['rebloggedPostId'];
    if (json.containsKey('type')) _type = json['type'];
    if (json.containsKey('blogId')) _blogData = Blog.fromJson(json['blogId']);
    if (json.containsKey('commentText')) _commentText = json['commentText'];
  }

  static Future<List<Notes>> getNotes(
      String mode, String token, String postId) async {
    List<Notes> notesResponse = [];
    Map<String, dynamic> response = await apiClient.sendGetRequest(
        'post/$postId/notes',
        query: {'mode': mode},
        headers: {'Authorization': token});
    try {
      notesResponse = Notes._parseResponseJsonNotes(response);
    } catch (error) {
      logger.e('error while fetching notes with id $postId and mode $mode');
    }
    return notesResponse;
  }

  static List<Notes> _parseResponseJsonNotes(Map<String, dynamic> response) {
    if (response.containsKey('error')) return [];
    List<Notes> notes = [];
    try {
      notes = List<Map<String, dynamic>>.from(response['data']).map((note) {
        try {
          return new Notes.fromJson(note);
        } catch (err) {
          logger.e('malformed note $err');
        }
      }).toList();
    } catch (err) {
      logger.e(err.toString());
    }
    return notes;
  }
}
