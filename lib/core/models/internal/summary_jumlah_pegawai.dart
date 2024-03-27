import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/internal/jenis_kelamin.dart';
import 'package:json_annotation/json_annotation.dart';

part 'summary_jumlah_pegawai.g.dart';

@JsonSerializable()
class SummaryJumlahPegawai extends ResponseObject {
  @JsonKey(name: 'total_pegawai')
  final int totalPegawai;

  @JsonKey(name: 'jenis_kelamin')
  final List<JenisKelamin> jenisKelamin;

  SummaryJumlahPegawai({
    this.totalPegawai,
    this.jenisKelamin,
  });

  factory SummaryJumlahPegawai.fromJson(Map<String, dynamic> json) =>
      _$SummaryJumlahPegawaiFromJson(json);

  static get serializer => _$SummaryJumlahPegawaiFromJson;
}
