import 'package:flutter/material.dart';

enum Environment {
  production,
  staging,
}

class EnvironmentConfig {
  const EnvironmentConfig({
    @required this.appName,
    @required this.environment,
    @required this.tempUrl,
    @required this.apiUrl,
    @required this.oneSignalAppId,
  });

  final String appName;
  final Environment environment;
  final String tempUrl;
  final String apiUrl;
  final String oneSignalAppId;

}