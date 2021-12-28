import 'package:tumblrx/services/api_provider.dart';
import 'package:logger/logger.dart';

// change this to MockHttpRepository to use mock server
final bool _useMock = false;
final apiClient = _useMock ? MockHttpRepository() : ApiHttpRepository();
final logger = Logger();
