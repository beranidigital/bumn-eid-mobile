import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/hc/bod_talent.dart';
import 'package:bumn_eid/core/models/hc/dekom_detailed_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dekom_detailed_response.g.dart';

@JsonSerializable(createToJson: false)
class DekomDetailedResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'total data')
  final int totalData;

  @JsonKey(name: 'data')
  final List<DekomDetailedItem> data;

  DekomDetailedResponse({this.success, this.message, this.totalData, this.data});

  factory DekomDetailedResponse.fromJson(Map<String, dynamic> json) =>
      _$DekomDetailedResponseFromJson(json);

  static get serializer => _$DekomDetailedResponseFromJson;
}