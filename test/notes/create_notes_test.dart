import 'package:test/test.dart';
import 'package:tumblrx/models/notes.dart';
import 'package:tumblrx/models/user/blog.dart';

void main() {
  group("create note", () {
    test("creating comment from json", () {
      Notes note = Notes.fromJson({
        "type": "comment",
        "commentText": "My super comment :)",
        "blogId": {
          "_id": "61b28a610a654cdd7b39171c",
          "title": "Untitled",
          "handle": "test",
          "owner": "61b28a610a654cdd7b391719",
          "avatar":
              "http://tumblrx.me:3000/uploads/blog/blog-1640803918661-undefined.png",
          "isAvatarCircle": true,
          "isFollowed": true
        },
      });

      expect(note.commentText, "My super comment :)");
      expect(note.type, "comment");
      Blog blogData = note.blogData;
      expect(blogData.id, "61b28a610a654cdd7b39171c");
      expect(blogData.title, "Untitled");
      expect(blogData.handle, "test");
      expect(blogData.blogAvatar,
          "http://tumblrx.me:3000/uploads/blog/blog-1640803918661-undefined.png");
    });
    test("creating like from json", () {
      Notes note = Notes.fromJson({
        "type": "like",
        "blogId": {
          "_id": "61b28a610a654cdd7b39171c",
          "title": "Untitled",
          "handle": "test",
          "owner": "61b28a610a654cdd7b391719",
          "avatar":
              "http://tumblrx.me:3000/uploads/blog/blog-1640803918661-undefined.png",
          "isAvatarCircle": true,
          "isFollowed": true
        },
      });

      expect(note.commentText, null);
      expect(note.type, "like");
      Blog blogData = note.blogData;
      expect(blogData.id, "61b28a610a654cdd7b39171c");
      expect(blogData.title, "Untitled");
      expect(blogData.handle, "test");
      expect(blogData.blogAvatar,
          "http://tumblrx.me:3000/uploads/blog/blog-1640803918661-undefined.png");
    });
  });
}
