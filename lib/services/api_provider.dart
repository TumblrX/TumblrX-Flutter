import 'package:http/http.dart';
import 'package:tumblrx/utilities/environment.dart';

/// MockAPI class to use for testing
class MockHttpRepository {
  /// API key for mock server
  static final String api = Environment.apiUrl;

  /// API to send get requests
  /// @endPoint : the end point to which send the request
  /// @req : request query parameters as map<String, dynamic>
  static Future sendGetRequest(String endPoint,
      {Map<String, dynamic> req}) async {
    String fullUrl = "$api/$endPoint?";

    // adding query parameters if any
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

  /// API to send post requests
  /// @endPoint : the end point to which send the request
  /// @req : request body as map<String, dynamic>
  static Future<Response> sendPostRequest(
      String endPoint, Map<String, dynamic> req,
      {Map<String, String> headers}) async {
    String fullUrl = "$api/$endPoint";

    // constructin the request body from passed map
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

/// Real API class
class ApiHttpRepository {
  /// API key for real server
  final String api = '';

  /// API to send get requests
  /// @endPoint : the end point to which send the request
  /// @req : request query parameters as map<String, dynamic>
  Future sendPostRequest(String endPoint, Map<String, dynamic> req) async {
    await Future.delayed(const Duration(seconds: 2));
    return;
  }

  /// API to send post requests
  /// @endPoint : the end point to which send the request
  /// @req : request body as map<String, dynamic>
  Future sendGetRequest(String endPoint, Map<String, dynamic> req) async {
    await Future.delayed(const Duration(seconds: 2));
    return;
  }
}
