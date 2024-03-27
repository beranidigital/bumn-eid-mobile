import 'dart:async';

import 'package:bumn_eid/core/utils/validators.dart';
import 'package:bumn_eid/ui/pages/home/welcome_page/bloc/welcome_page_action_mapper.dart';
import 'package:bumn_eid/ui/utils/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class WelcomePageBloc extends Bloc with Validators {

  final WelcomePageActionMapper actionMapper;

  WelcomePageBloc({
    @required
    this.actionMapper
  });

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Stream<String> get emailStream => _emailController.stream.transform(validateEmail).asBroadcastStream();
  Stream<String> get passwordStream => _passwordController.stream.transform(validatePassword).asBroadcastStream();

  Function(String) get inputEmail => _emailController.sink.add;
  Function(String) get inputPassword => _passwordController.sink.add;

  Stream<bool> get submitEnabled => CombineLatestStream.combine2(
      emailStream,
      passwordStream,
      (a,b) => true
  ).asBroadcastStream();

  void submitLogin() => actionMapper.submitLogin(email: _emailController.value, password: _passwordController.value);

  @override
  void dispose() {
    _emailController.close();
    _passwordController.close();
  }

}