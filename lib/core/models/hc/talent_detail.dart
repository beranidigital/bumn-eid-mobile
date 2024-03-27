import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'talent_detail.g.dart';

@JsonSerializable(createToJson: false)
class TalentDetail extends ResponseObject {

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'id_angka')
  final String companyId;

  @JsonKey(name: 'nama_lengkap')
  final String companyName;

  @JsonKey(name: 'nama_pendek')
  final String companyShortName;

  @JsonKey(name: 'nama')
  final String name;

  @JsonKey(name: 'tgl_lahir')
  final String birthDate;

  @JsonKey(name: 'periode')
  final String periode;

  @JsonKey(name: 'pangkat')
  final String pangkat;

  @JsonKey(name: 'kategori_pangkat')
  final String kategoriPangkat;

  @JsonKey(name: 'bidang')
  final String bidang;

  @JsonKey(name: 'sk')
  final String sk;

  @JsonKey(name: 'tanggal_sk')
  final String tanggalSk;

  @JsonKey(name: 'sk_akhir')
  final String skAkhir;

  @JsonKey(name: 'sk_henti')
  final String skHenti;

  @JsonKey(name: 'mulai_jabat')
  final String mulaiJabat;

  @JsonKey(name: 'akhir_jabat')
  final String akhirJabat;

  @JsonKey(name: 'instansi_asal')
  final String instansiAsal;

  @JsonKey(name: 'tanggal_akhir_rups')
  final String tanggalAkhirRups;

  @JsonKey(name: 'tgl_serah_terima')
  final String tanggalSerahTerima;

  @JsonKey(name: 'sisa_masa_jabatan')
  final String sisaMasaJabatan;

  @JsonKey(name: 'keterangan')
  final String keterangan;

  @JsonKey(name: 'cluster_bumn')
  final String clusterBumn;

  @JsonKey(name: 'wamen_bumn')
  final String wamenBumn;

  @JsonKey(name: 'kelas_bumn')
  final String kelasBumn;

  @JsonKey(name: 'group_asal')
  final String group;

  @JsonKey(name: 'top_bumn')
  final String topBumn;

  @JsonKey(name: 'asdep')
  final String asdep;

  @JsonKey(name: 'klasifikasi_asal_instansi_dekom')
  final String klasifikasi;

  @JsonKey(name: 'fungsi_direksi')
  final int fungsiDireksi;

  @JsonKey(name: 'status_bumn')
  final String statusBumn;

  @JsonKey(name: 'skala_jabatan_bumn')
  final String skalaJabatan;

  @JsonKey(name: 'jenis_kelamin')
  final String gender;

  @JsonKey(name: 'kelompok_usia')
  final String kelompokUsia;

  @JsonKey(name: 'usia')
  final int usia;

  @JsonKey(name: 'klasifikasi_group_asal')
  final String klasifikasiGroupAsal;

  TalentDetail({this.id, this.companyId, this.companyName, this.kelasBumn, this.name, this.group, this.asdep, this.klasifikasi,
        this.wamenBumn, this.clusterBumn, this.bidang, this.companyShortName, this.fungsiDireksi, this.pangkat, this.topBumn,
        this.akhirJabat, this.keterangan, this.birthDate, this.instansiAsal, this.mulaiJabat, this.periode, this.sisaMasaJabatan,
        this.sk, this.skAkhir, this.skHenti, this.tanggalAkhirRups, this.tanggalSerahTerima, this.tanggalSk, this.gender,
        this.kelompokUsia, this.klasifikasiGroupAsal, this.skalaJabatan, this.statusBumn, this.usia, this.kategoriPangkat});

  factory TalentDetail.fromJson(Map<String, dynamic> json) =>
      _$TalentDetailFromJson(json);

  static get serializer => _$TalentDetailFromJson;

}