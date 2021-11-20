import 'package:http/http.dart';
import 'package:http/http.dart';

class MockHttpRepository {
  static final String api =
      'https://54bd9e92-6a19-4377-840f-23886631e1a8.mock.pstmn.io/';

  static Future sendGetRequest(
      String endPoint, Map<String, dynamic> req) async {
    String fullUrl = "$api/$endPoint?";
    for (var reqParam in req.entries) {
      if (reqParam.value is String)
        fullUrl += '${reqParam.key}="${reqParam.value}"';
      else
        fullUrl += '${reqParam.key}=${reqParam.value}';
    }
    final Uri uri = Uri.parse(fullUrl);

    return get(uri);
  }

  static Future<Response> sendPostRequest(
      String endPoint, Map<String, dynamic> req,
      {Map<String, String> headers}) async {
    String fullUrl = "$api/$endPoint";
    String reqBody = "";
    for (var reqParam in req.entries) {
      if (reqParam.value is String)
        reqBody += '${reqParam.key}="${reqParam.value}"';
      else
        reqBody += '${reqParam.key}=${reqParam.value}';
    }
    final Uri uri = Uri.parse(fullUrl);
    return post(uri, body: reqBody);
  }
}

class ApiHttpRepository {
  const ApiHttpRepository();

  Future sendPostRequest(String endPoint, Map<String, dynamic> req) async {
    await Future.delayed(const Duration(seconds: 2));
    return;
  }

  Future sendGetRequest(String endPoint, Map<String, dynamic> req) async {
    await Future.delayed(const Duration(seconds: 2));
    return;
  }
}
