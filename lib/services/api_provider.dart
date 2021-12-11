import 'package:http/http.dart';

class MockHttpRepository {
  static final String api =   
      'https://42df9e63-8c72-4982-889d-d3bafb7577bf.mock.pstmn.io/';

  static Future sendGetRequest(String endPoint,
      {Map<String, dynamic> req}) async {
    String fullUrl = "$api/$endPoint?";

    if (req != null)
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
