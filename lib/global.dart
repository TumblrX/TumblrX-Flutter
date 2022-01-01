import 'package:tumblrx/services/api_provider.dart';
import 'package:logger/logger.dart';

// change this to MockHttpRepository to use mock server
final bool _useMock = false;

/// api client object to use for sending requests
final apiClient = _useMock ? MockHttpRepository() : ApiHttpRepository();

/// logger object for better debugging/monitoring the application status
final logger = Logger();
