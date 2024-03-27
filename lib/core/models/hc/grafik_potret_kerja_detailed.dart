import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grafik_potret_kerja_detailed.g.dart';

@JsonSerializable(createToJson: false)
class GrafikPotretTugasDetailed extends ResponseObject {

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'nama')
  final String nama;

  @JsonKey(name: 'nama_lengkap')
  final String namaPerusahaan;

  @JsonKey(name: 'akhir_jabat')
  final String akhirJabat;

  @JsonKey(name: 'periode')
  final String periode;

  @JsonKey(name: 'persentase')
  final String persentase;

  @JsonKey(name: 'sisa_in_days')
  final int sisaJabatanDays;

  @JsonKey(name: 'fromitms')
  final bool fromItms;

  GrafikPotretTugasDetailed({
    this.id, this.nama, this.namaPerusahaan, this.periode, this.persentase, this.akhirJabat, this.sisaJabatanDays, this.fromItms = false});

  factory GrafikPotretTugasDetailed.fromJson(Map<String, dynamic> json) =>
      _$GrafikPotretTugasDetailedFromJson(json);

  static get serializer => _$GrafikPotretTugasDetailedFromJson;

}