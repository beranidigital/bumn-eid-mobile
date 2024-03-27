import 'package:bumn_eid/core/exceptions/user_friendly_exception.dart';
// An exception thrown manually by ourselves. Contains a description of what's going plus the inner exception.

class CustomException implements UserFriendlyException {
  String detail;
  // TODO: It throws an error when there's an `Error` data type supplied here
  // TODO: https://stackoverflow.com/questions/17315945/error-vs-exception-in-dart
  // TODO: look for a better data type here.
  dynamic innerException;

  CustomException(this.detail, this.innerException);

  String getUserFriendlyMessage() {
    return detail;
  }

  @override
  String toString() {
    return getUserFriendlyMessage();
  }
}
