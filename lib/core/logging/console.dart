// A logging integration that logs messages to console using standard print() function
import 'package:bumn_eid/core/logging/logger.dart';
import 'package:bumn_eid/core/logging/logging_level.dart';

class ConsoleLoggingIntegration implements LoggingIntegration {
  const ConsoleLoggingIntegration();

  @override
  void log(String message, LoggingLevel level) {
    print(message);
  }
}
