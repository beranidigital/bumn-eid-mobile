import 'package:bumn_eid/core/api/api_client.dart';
import 'package:bumn_eid/core/api/request/login_driver_qr_request_object.dart';
import 'package:bumn_eid/core/api/request/login_driver_request_object.dart';
import 'package:bumn_eid/core/api/request/refresh_session_request_object.dart';
import 'package:bumn_eid/core/api/response/session/session_response.dart';
import 'package:bumn_eid/core/logging/logger.dart';
import 'package:flutter/material.dart';

class AuthClient extends ApiClient {
  AuthClient({
    @required String apiKey,
    @required String baseUrl,
    @required Logger logger,
  }) : super(apiKey, baseUrl, logger);

  Future<SessionResponse> login(LoginDriverRequestObject requestObject) async {
    final String endpoint = 'login';

    return await post(
        endpoint: endpoint,
        body: requestObject.getJsonBody(),
        serializer: SessionResponse.serializer);
  }

  Future<SessionResponse> loginWithQR(
      LoginDriverQRRequestObject requestObject) async {
    final String endpoint = 'login/qr';

    return await post(
      endpoint: endpoint,
      body: requestObject.getJsonBody(),
      serializer: SessionResponse.serializer,
    );
  }

  Future<SessionResponse> refreshToken(
      RefreshSessionRequestObject requestObject) async {
    final String endpoint = 'session/refresh';

    return await post(
        endpoint: endpoint,
        body: requestObject.getJsonBody(),
        serializer: SessionResponse.serializer);
  }
}
