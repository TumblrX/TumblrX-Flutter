import 'package:tumblrx/models/chatting/conversation.dart';
import 'package:tumblrx/services/messaging.dart';
import 'package:tumblrx/utilities/time_format_to_view.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final messaging = Messaging();
  messaging.conversations = [
    Conversation.fromJson({
      'chatId': '123',
      'textedUser': '321',
      'messageDate': '1999-11-21T15:47:33.371Z',
      'blogHandle': 'MohamedSalah',
      'avatar':
          "http://tumblrx.me:3000/uploads/post/image/post-1639258474966-61b28a610a654cdd7b39171c.jpeg",
      'message': 'hello from the other side',
      'isMe': true
    })
  ];
  messaging.conversations[0].addMessage(
      'hello from the other side', true, '1999-11-21T15:47:33.371Z');
  group('testing conversation model from json reading', () {
    test('blog handle should be Mohamed Salah', () {
      expect(messaging.conversations[0].username, 'MohamedSalah');
    });
    test('lastMessageIsMe should be true', () {
      expect(messaging.conversations[0].lastMessageIsMe, true);
    });
  });
  group('testing conversations and messaging', () {
    messaging.conversations[0]
        .addMessage('hello again', false, '1999-11-21T15:47:33.371Z');
    test('Number of messages should be 2', () {
      expect(messaging.conversations[0].chatMessages.length, 2);
    });

    test('Number of messages should be 3 after receive message', () {
      messaging.receiveMessage('third message', '321', '111');
      expect(messaging.getChatMessages('321').length, 3);
    });

    test('Number of unseen messages should be 2', () {
      messaging.receiveMessage('third message', '321', '111');
      expect(messaging.totalUnseenMessage, 2);
    });

    test('chat messages list should be empty list for non existing user chat',
        () {
      expect(messaging.getChatMessages('414141'), []);
    });
  });
}
