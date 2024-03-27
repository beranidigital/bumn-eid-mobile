import 'dart:async';

import 'package:bumn_eid/core/strings/strings.dart';

// Validator Mixin
class Validators {
  final validateEmail = StreamTransformer<String, String>.fromHandlers(
      handleData: (email, sink) {
        if(email.contains(RegExp("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"))) {
          sink.add(email);
        } else {
          sink.addError(Strings.getString("WelcomePage.EmailError"));
        }
      }
  );

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (email, sink) {
        if(email.length > 4) {
          sink.add(email);
        } else {
          sink.addError(Strings.getString("WelcomePage.PasswordError"));
        }
      }
  );
}