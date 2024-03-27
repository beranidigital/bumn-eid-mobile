import 'package:flutter/material.dart';

abstract class WelcomePageEvent {}

class InputEmailEvent extends WelcomePageEvent {
  final String email;

  InputEmailEvent({@required this.email});
}

class InputPasswordEvent extends WelcomePageEvent {
  final String password;

  InputPasswordEvent({@required this.password});
}

class ResetFormEvent extends WelcomePageEvent {}

class SubmitLoginEvent extends WelcomePageEvent {}