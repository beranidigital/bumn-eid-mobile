import 'package:bumn_eid/core/api/clients/auth_client.dart';
import 'package:bumn_eid/core/api/request/login_driver_qr_request_object.dart';
import 'package:bumn_eid/core/api/request/login_driver_request_object.dart';
import 'package:bumn_eid/core/api/request/refresh_session_request_object.dart';
import 'package:bumn_eid/core/api/response/session/session_response.dart';
import 'package:bumn_eid/core/logging/logger.dart';
import 'package:bumn_eid/core/models/common/user.dart';
import 'package:flutter/material.dart';

class SessionController {
  final AuthClient authClient;
  final Logger logger;
  User currentUser;

  SessionController({
    @required this.authClient,
    @required this.logger,
  });

  setUser(User user) => currentUser = user;

  String getToken() => currentUser?.token;
  String getEmail() => currentUser?.email;

  Future<SessionResponse> login(
      {@required String email, @required String password}) async {
    final requestObject =
        LoginDriverRequestObject(email: email, password: password);

    final session = await authClient.login(requestObject);
    User newUser = User(
        id: session.data.user.id,
        email: session.data.user.email,
        name: session.data.user.name,
        token: session.data.user.token,
        role: session.data.role);

    currentUser = newUser;
    return session;
  }

  Future<SessionResponse> loginWithQR({
    @required String qrCode,
  }) async {
    final requestObject = LoginDriverQRRequestObject(
      qrCode: qrCode,
    );

    final session = await authClient.loginWithQR(requestObject);
    User newUser = User(
        id: session.data.user.id,
        email: session.data.user.email,
        name: session.data.user.name,
        token: session.data.user.token,
        role: session.data.role);

    currentUser = newUser;
    return session;
  }

  Future<SessionResponse> refreshSession() async {
    final requestObject =
        RefreshSessionRequestObject(refreshToken: currentUser?.token);

    final session = await authClient.refreshToken(requestObject);
    currentUser = session.data.user;
    return session;
  }
}
