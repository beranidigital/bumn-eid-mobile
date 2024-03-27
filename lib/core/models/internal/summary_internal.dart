import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/internal/agama.dart';
import 'package:bumn_eid/core/models/internal/jabatan.dart';
import 'package:bumn_eid/core/models/internal/pendidikan.dart';
import 'package:bumn_eid/core/models/internal/pref_jabatan.dart';
import 'package:bumn_eid/core/models/internal/status_nikah.dart';
import 'package:bumn_eid/core/models/internal/status_pegawai.dart';
import 'package:bumn_eid/core/models/internal/summary_jumlah_pegawai.dart';
import 'package:bumn_eid/core/models/internal/summary_usia.dart';
import 'package:bumn_eid/core/models/internal/unit_kerja.dart';
import 'package:json_annotation/json_annotation.dart';

part 'summary_internal.g.dart';

@JsonSerializable()
class SummaryInternal extends ResponseObject {
  @JsonKey(name: 'summary_jumlah_pegawai')
  final SummaryJumlahPegawai summaryJumlahPegawai;

  @JsonKey(name: 'summary_usia')
  final List<SummaryUsia> summaryUsia;

  @JsonKey(name: 'summary_pendidikan')
  final List<Pendidikan> summaryPendidikan;

  @JsonKey(name: 'summary_agama')
  final List<Agama> summaryAgama;

  @JsonKey(name: 'summary_status_nikah')
  final List<StatusNikah> summaryStatusNikah;

  @JsonKey(name: 'summary_status_pegawai')
  final List<StatusPegawai> summaryStatusPegawai;

  @JsonKey(name: 'summary_jabatan')
  final List<Jabatan> summaryJabatan;

  @JsonKey(name: 'summary_unit_kerja')
  final List<UnitKerja> summaryUnitKerja;

  @JsonKey(name: 'summary_pref_jabatan')
  final List<PrefJabatan> summaryPrefJabatan;

  SummaryInternal({
    this.summaryJumlahPegawai,
    this.summaryUsia,
    this.summaryPendidikan,
    this.summaryAgama,
    this.summaryStatusNikah,
    this.summaryStatusPegawai,
    this.summaryJabatan,
    this.summaryUnitKerja,
    this.summaryPrefJabatan,
  });

  factory SummaryInternal.fromJson(Map<String, dynamic> json) =>
      _$SummaryInternalFromJson(json);

  static get serializer => _$SummaryInternalFromJson;
}
