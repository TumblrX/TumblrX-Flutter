import 'package:flutter_test/flutter_test.dart';
import 'package:tumblrx/services/authentication.dart';

void main() {
  test('textfield validator show error message for empty email ', () {
    String result = Authentication().checkValidEmail('');
    expect(result, 'Please enter some text');
  });

  test('textfield validator show error message for unvalid email format', () {
    String result = Authentication().checkValidEmail('omar.any.com');
    expect(result, 'unvalid email');
  });

  test('textfield validator return null if the email is valid', () {
    String result = Authentication().checkValidEmail('omar@any.com');
    expect(result, null);
  });

  test('textfield validator show error message for empty password ', () {
    String result = Authentication().checkValidName('');
    expect(result, 'Please enter some text');
  });

  test('textfield validator  return null if the user entered a password ', () {
    String result = Authentication().checkValidName('oamr23');
    expect(result, null);
  });
  test('textfield validator show error message for empty name ', () {
    String result = Authentication().checkValidName('');
    expect(result, 'Please enter some text');
  });

  test('textfield validator  return null if the user entered a name', () {
    String result = Authentication().checkValidName('omar');
    expect(result, null);
  });
}
