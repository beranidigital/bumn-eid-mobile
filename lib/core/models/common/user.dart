import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'api_token')
  final String token;

  final List<String> role;

  const User(
      {this.id, this.name, this.email, this.token, this.role = const []});

  Map toJson() {
    return _$UserToJson(this);
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
