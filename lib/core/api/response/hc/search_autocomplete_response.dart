import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/common/anak_perusahaan_deni.dart';
import 'package:bumn_eid/core/models/hc/search_result.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_autocomplete_response.g.dart';

@JsonSerializable(createToJson: false)
class SearchAutocompleteResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final List<SearchResult> autocomplete;

  SearchAutocompleteResponse({this.success, this.message, this.autocomplete});

  factory SearchAutocompleteResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchAutocompleteResponseFromJson(json);

  static get serializer => _$SearchAutocompleteResponseFromJson;
}