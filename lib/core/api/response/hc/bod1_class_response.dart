import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/hc/bod1_class.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bod1_class_response.g.dart';

@JsonSerializable(createToJson: false)
class BOD1ClassResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final List<BOD1Class> companies;

  BOD1ClassResponse({this.success, this.message, this.companies});

  factory BOD1ClassResponse.fromJson(Map<String, dynamic> json) =>
      _$BOD1ClassResponseFromJson(json);

  static get serializer => _$BOD1ClassResponseFromJson;
}