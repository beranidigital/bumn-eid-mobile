import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_result.g.dart';

@JsonSerializable(createToJson: false)
class SearchResult extends ResponseObject {

  @JsonKey(name: 'nama')
  final String name;

  SearchResult({this.name});

  factory SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);

  static get serializer => _$SearchResultFromJson;

}