// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_autocomplete_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchAutocompleteResponse _$SearchAutocompleteResponseFromJson(
    Map<String, dynamic> json) {
  return SearchAutocompleteResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    autocomplete: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : SearchResult.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
