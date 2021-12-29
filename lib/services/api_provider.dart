import 'package:http/http.dart';
import 'package:tumblrx/global.dart';
import 'package:tumblrx/utilities/environment.dart';
import 'dart:convert' as convert;

abstract class API {
  Future<Map<String, dynamic>> sendPostRequest(String endPoint,
      {Map<String, dynamic> reqBody, Map<String, String> headers});
  Future<Map<String, dynamic>> sendGetRequest(String endPoint,
      {Map<String, String> headers, Map<String, dynamic> query});
  Future<Map<String, dynamic>> sendDeleteRequest(
      String endPoint, Map<String, String> headers,
      {Map<String, dynamic> reqBody});
}

/// MockAPI class to use for testing
class MockHttpRepository implements API {
  /// API key for mock server
  static final String api =
      'https://42df9e63-8c72-4982-889d-d3bafb7577bf.mock.pstmn.io/';

  /// API to send get requests
  /// @endPoint : the end point to which send the request
  /// @req : request query parameters as map<String, dynamic>
  Future<Map<String, dynamic>> sendGetRequest(String endPoint,
      {Map<String, String> headers, Map<String, dynamic> query}) async {
    String fullUrl = "$api/$endPoint?";

    // adding query parameters if any
    if (query != null)
      for (var reqParam in query.entries) {
        if (reqParam.value is String)
          fullUrl += '${reqParam.key}="${reqParam.value}"';
        else
          fullUrl += '${reqParam.key}=${reqParam.value}';
      }

    final Uri uri = Uri.parse(fullUrl);
    final Response response = await get(uri, headers: headers);
    if (response.statusCode != 200)
      return {'statuscode': response.statusCode, 'error': response.body};
    Map<String, dynamic> result =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    result['statuscode'] = 200;
    return result;
  }

  /// API to send post requests
  /// @endPoint : the end point to which send the request
  /// @req : request body as map<String, dynamic>
  Future<Map<String, dynamic>> sendPostRequest(String endPoint,
      {Map<String, dynamic> reqBody, Map<String, String> headers}) async {
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
    if (headers == null) return {'error': 'headers can not be null'};
    final Response response = reqBody != null
        ? await post(uri, body: reqBody, headers: headers)
        : await post(uri, headers: headers);
    if (response.statusCode != 200)
      return {'statuscode': response.statusCode, 'error': response.body};
    Map<String, dynamic> result =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    result['statuscode'] = 200;
    return result;
  }

  @override
  Future<Map<String, dynamic>> sendDeleteRequest(
      String endPoint, Map<String, String> headers,
      {Map<String, dynamic> reqBody}) async {
    if (headers == null) return {'error': 'headers can not be null'};
    String url = '$api$endPoint';
    final Uri uri = Uri.parse(url);
    final Response response = reqBody != null
        ? await delete(uri, headers: headers, body: reqBody)
        : await delete(uri, headers: headers);
    if (response.statusCode != 200)
      return {'statuscode': response.statusCode, 'error': response.body};
    if (response.body.isEmpty) return {};
    Map<String, dynamic> result =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    result['statuscode'] = 200;
    return result;
  }
}

/// Real API class
class ApiHttpRepository implements API {
  /// API key for real server
  static final String api = Environment.apiUrl;

  /// API to send get requests
  /// @endPoint : the end point to which send the request
  /// @req : request query parameters as map<String, dynamic>
  @override
  Future<Map<String, dynamic>> sendPostRequest(String endPoint,
      {Map<String, dynamic> reqBody, Map<String, String> headers}) async {
    String fullUrl = '$api$endPoint';
    // if (reqBody != null) {
    //   reqBody.forEach((key, value) {
    //     fullUrl += '/${value.toString()}';
    //   });
    // }
    final Uri uri = Uri.parse(fullUrl);
    final Response response = headers != null
        ? await post(uri, body: reqBody, headers: headers)
        : await post(uri, body: reqBody);
    if (response.statusCode != 200)
      return {'statuscode': response.statusCode, 'error': response.body};
    if (response.body.isEmpty) return {};
    Map<String, dynamic> result =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    result['statuscode'] = 200;

    return result;
  }

  /// API to send post requests
  /// @endPoint : the end point to which send the request
  /// @req : request body as map<String, dynamic>
  @override
  Future<Map<String, dynamic>> sendGetRequest(String endPoint,
      {Map<String, String> headers, Map<String, dynamic> query}) async {
    if (query != null) {
      endPoint = endPoint + '?';
      query.forEach((key, value) {
        endPoint = '$endPoint$key=$value&';
      });
      endPoint = endPoint.substring(0, endPoint.length - 1);
    }
    final Uri uri = Uri.parse('${api}api/$endPoint');
    //logger.d(uri.toString());
    final Response response =
        headers != null ? await get(uri, headers: headers) : await get(uri);
    if (response.statusCode != 200)
      return {'statuscode': response.statusCode, 'error': response.body};

    Map<String, dynamic> result =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    result['statuscode'] = 200;

    return result;
  }

  @override
  Future<Map<String, dynamic>> sendDeleteRequest(
      String endPoint, Map<String, String> headers,
      {Map<String, dynamic> reqBody}) async {
    if (headers == null) return {'error': 'headers can not be null'};
    String url = '$api$endPoint';
    final Uri uri = Uri.parse(url);
    final Response response = reqBody != null
        ? await delete(uri, headers: headers, body: reqBody)
        : await delete(uri, headers: headers);
    if (response.statusCode != 200)
      return {'statuscode': response.statusCode, 'error': response.body};

    Map<String, dynamic> result =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    result['statuscode'] = 200;

    return result;
  }
}
