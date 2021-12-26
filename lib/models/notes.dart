/*
Author: Passant Abdelgalil
Description: 
    A class to build an object to store notes data to be used later
*/

import 'package:http/http.dart';
import 'package:tumblrx/models/user/blog.dart';
import 'package:tumblrx/services/api_provider.dart';
import 'dart:convert' as convert;

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
    Response response = await ApiHttpRepository.sendGetRequest(
        'post/$postId/notes',
        query: {'mode': mode},
        headers: {'Authorization': token});
    try {
      notesResponse = Notes._parseResponseJsonNotes(response);
      print(notesResponse.toString());
    } catch (error) {
      print('error while fetching notes with id $postId and mode $mode');
    }
    ;
    return notesResponse;
  }

  static List<Notes> _parseResponseJsonNotes(Response response) {
    if (response.statusCode != 200) return [];
    print(response.body);
    // decode reponse
    final Map<String, dynamic> resposeObject =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    List<Notes> notes = [];
    try {
      notes =
          List<Map<String, dynamic>>.from(resposeObject['data']).map((note) {
        try {
          return new Notes.fromJson(note);
        } catch (err) {
          print('malformed note $err');
        }
      }).toList();
    } catch (err) {
      print(err);
    }
    return notes;
  }
}
