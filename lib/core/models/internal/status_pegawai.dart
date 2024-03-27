import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'status_pegawai.g.dart';

@JsonSerializable()
class StatusPegawai extends ResponseObject {
  @JsonKey(name: 'status_pegawai')
  final String statusPegawai;

  @JsonKey(name: 'total')
  final int total;

  StatusPegawai({
    this.statusPegawai,
    this.total,
  });

  factory StatusPegawai.fromJson(Map<String, dynamic> json) =>
      _$StatusPegawaiFromJson(json);

  static get serializer => _$StatusPegawaiFromJson;
}
