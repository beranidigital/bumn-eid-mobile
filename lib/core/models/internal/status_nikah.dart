import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'status_nikah.g.dart';

@JsonSerializable()
class StatusNikah extends ResponseObject {
  @JsonKey(name: 'status_nikah')
  final String statusNikah;

  @JsonKey(name: 'total')
  final int total;

  StatusNikah({
    this.statusNikah,
    this.total,
  });

  factory StatusNikah.fromJson(Map<String, dynamic> json) =>
      _$StatusNikahFromJson(json);

  static get serializer => _$StatusNikahFromJson;
}
