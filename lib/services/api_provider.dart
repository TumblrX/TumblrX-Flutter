import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

abstract class HttpRepository {
  const HttpRepository();

  Future sendGetRequest(String endPoint, Map<String, dynamic> req);
  Future sendPostRequest(String endPoint, Map<String, dynamic> req);
}

class MockHttpRepository extends HttpRepository {
  final String api =
      'https://54bd9e92-6a19-4377-840f-23886631e1a8.mock.pstmn.io/';
  const MockHttpRepository();
  @override
  Future sendGetRequest(String endPoint, Map<String, dynamic> req) async {
    final Uri uri = Uri.parse('$api/$endPoint');
    http.get(uri);
    await Future.delayed(const Duration(seconds: 2));
    return;
  }

  @override
  Future sendPostRequest(String endPoint, Map<String, dynamic> req) async {
    // TODO: implement sendRequest
    await Future.delayed(const Duration(seconds: 2));
    return;
  }
}

class ApiHttpRepository extends HttpRepository {
  const ApiHttpRepository();

  @override
  Future sendPostRequest(String endPoint, Map<String, dynamic> req) async {
    // TODO: implement REAL sendRequest
    await Future.delayed(const Duration(seconds: 2));
    return;
  }

  @override
  Future sendGetRequest(String endPoint, Map<String, dynamic> req) async {
    // TODO: implement sendRequest
    await Future.delayed(const Duration(seconds: 2));
    return;
  }
}
