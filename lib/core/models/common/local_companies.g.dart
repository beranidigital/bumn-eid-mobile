// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_companies.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalCompanies _$LocalCompaniesFromJson(Map<String, dynamic> json) {
  return LocalCompanies(
    companies: (json['companies'] as List)
        ?.map((e) => e == null
            ? null
            : ProfilPerusahaan.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    savedTime: json['saved_time'] == null
        ? null
        : DateTime.parse(json['saved_time'] as String),
  );
}

Map<String, dynamic> _$LocalCompaniesToJson(LocalCompanies instance) =>
    <String, dynamic>{
      'companies': instance.companies,
      'saved_time': instance.savedTime?.toIso8601String(),
    };
