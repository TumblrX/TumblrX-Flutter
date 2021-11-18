abstract class HttpRepository {
  const HttpRepository();

  Future sendRequest(String type, Map<String, dynamic> req);
}

class MockHttpRepository extends HttpRepository {
  const MockHttpRepository();
  @override
  Future sendRequest(String type, Map<String, dynamic> req) async {
    // TODO: implement sendRequest
    await Future.delayed(const Duration(seconds: 2));
    return;
  }
}

class ApiHttpRepository extends HttpRepository {
  const ApiHttpRepository();

  @override
  Future sendRequest(String type, Map<String, dynamic> req) async {
    // TODO: implement REAL sendRequest
    await Future.delayed(const Duration(seconds: 2));
    return;
  }
}
