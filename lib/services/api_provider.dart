import 'package:http/http.dart';
import 'package:tumblrx/utilities/environment.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

/// MockAPI class to use for testing
class MockHttpRepository {
  /// API key for mock server
  static final String api =
      'https://42df9e63-8c72-4982-889d-d3bafb7577bf.mock.pstmn.io/';

  /// API to send get requests
  /// @endPoint : the end point to which send the request
  /// @req : request query parameters as map<String, dynamic>
  static Future sendGetRequest(String endPoint,
      {Map<String, dynamic> queryParams}) async {
    String fullUrl = "$api/$endPoint?";

    // adding query parameters if any
    if (queryParams != null)
      for (var reqParam in queryParams.entries) {
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
  static Future<Response> sendPostRequest(String endPoint,
      {String reqBody, Map<String, String> headers}) async {
    String fullUrl = "$api/$endPoint";

    // // constructin the request body from passed map
    // String reqBody = "";
    // for (var reqParam in req.entries) {
    //   if (reqParam.value is String)
    //     reqBody += '${reqParam.key}="${reqParam.value}"';
    //   else
    //     reqBody += '${reqParam.key}=${reqParam.value}';
    // }
    final Uri uri = Uri.parse(fullUrl);
    if (headers != null && reqBody != null)
      return post(uri, body: reqBody, headers: headers);
    if (reqBody != null) return post(uri, body: reqBody);
    if (headers != null) return post(uri, headers: headers);
    return post(uri);
  }
}

/// Real API class
class ApiHttpRepository {
  /// API key for real server
  static final String api = Environment.apiUrl;

  /// API to send get requests
  /// @endPoint : the end point to which send the request
  /// @req : request query parameters as map<String, dynamic>
  static Future sendPostRequest(String endPoint,
      {Map<String, dynamic> reqBody, Map<String, dynamic> headers}) async {
    String fullUrl = '$api$endPoint';
    // if (reqBody != null) {
    //   reqBody.forEach((key, value) {
    //     fullUrl += '/${value.toString()}';
    //   });
    // }
    final Uri uri = Uri.parse(fullUrl);

    if (headers != null) return post(uri, body: reqBody, headers: headers);
    return post(uri, body: reqBody);
  }

  /// API to send post requests
  /// @endPoint : the end point to which send the request
  /// @req : request body as map<String, dynamic>
  static Future sendGetRequest(String endPoint,
      {Map<String, String> headers, Map<String, dynamic> query}) async {
    if (query != null) {
      endPoint = endPoint + '?';
      query.forEach((key, value) {
        endPoint = '$endPoint$key=$value&';
      });
      endPoint = endPoint.substring(0, endPoint.length - 1);
    }
    final Uri uri = Uri.parse('${api}api/$endPoint');
    if (headers != null) return await get(uri, headers: headers);
    return await get(uri);
  }

  static Future sendDeleteRequest(String endPoint, Map<String, String> headers,
      {Map<dynamic, dynamic> reqBody}) {
    String url = '$api$endPoint';
    final Uri uri = Uri.parse(url);

    if (headers != null && reqBody != null)
      return delete(uri, headers: headers, body: reqBody);
    if (reqBody != null) return delete(uri, body: reqBody);
    if (headers != null) return delete(uri, headers: headers);
    return delete(uri);
  }
//send PUT Request

  static Future sendPutRequest(String endPoint, Map<String, String> headers,
      Map<dynamic, dynamic> reqBody) async {
    String url = '$api$endPoint';
    final Uri uri = Uri.parse(url);

    if (reqBody != null) return http.put(uri, headers: headers, body: reqBody);
    return put(uri);
  }
}
