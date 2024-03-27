// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  try {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      token: json['api_token'] as String,
      role: (json['role'] as List)?.map((e) => e as String)?.toList(),
    );
  } catch (ex) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      token: json['api_token'] as String,
      role: [
        'portofolio',
        'finance',
        'hc',
        'legal',
        'csr',
        'event',
        'pmo',
        'covid'
      ],
    );
  }
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'api_token': instance.token,
      'role': instance.role,
    };
