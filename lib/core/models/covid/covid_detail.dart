import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'covid_detail.g.dart';

@JsonSerializable()
class CovidDetail extends ResponseObject {

  @JsonKey(name: 'grand_total')
  final int grandTotal;

  @JsonKey(name: 'last_update')
  final String lastUpdate;

  @JsonKey(name: 'jumlah_taskforce')
  final int jumlahTaskforce;

  @JsonKey(name: 'jumlah_protokol')
  final int jumlahProtokol;

  @JsonKey(name: 'jumlah_sosialisasi')
  final int jumlahSosialisasi;

  @JsonKey(name: 'grand_total_color')
  final int grandTotalColor;

  @JsonKey(name: 'jumlah_taskforce_color')
  final int jumlahTaskforceColor;

  @JsonKey(name: 'jumlah_protokol_color')
  final int jumlahProtokolColor;

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'id_angka')
  final String idAngka;

  @JsonKey(name: 'nama_lengkap')
  final String namaLengkap;

  @JsonKey(name: 'taskforce')
  final String taskForce;

  @JsonKey(name: 'is_taskforce')
  final String isTaskForce;

  @JsonKey(name: 'sop_karyawan')
  final String sopKaryawan;

  @JsonKey(name: 'is_sop_karyawan')
  final String isSopKaryawan;

  @JsonKey(name: 'sop_pelanggan')
  final String sopPelanggan;

  @JsonKey(name: 'is_sop_pelanggan')
  final String isSopPelanggan;

  @JsonKey(name: 'sop_supplier')
  final String sopSupplier;

  @JsonKey(name: 'is_sop_supplier')
  final String isSopSupplier;

  @JsonKey(name: 'sop_mitra')
  final String sopMitra;

  @JsonKey(name: 'is_sop_mitra')
  final String isSopMitra;

  @JsonKey(name: 'sop_stakeholder')
  final String sopStakeholder;

  @JsonKey(name: 'is_sop_stakeholder')
  final String isSopStakeholder;

  @JsonKey(name: 'sosialisasi_karyawan')
  final String sosialisasi;

  @JsonKey(name: 'is_sosialisasi_karyawan')
  final String isSosialisasi;

  @JsonKey(name: 'sosialisasi_pelanggan')
  final String sosialisasiplgn;

  @JsonKey(name: 'is_sosialisasi_pelanggan')
  final String isSosialisasiplgn;

  @JsonKey(name: 'sosialisasi_supplier')
  final String sosialisasiSupplier;

  @JsonKey(name: 'is_sosialisasi_supplier')
  final String isSosialisasiSupplier;

  @JsonKey(name: 'sosialisasi_mitra')
  final String sosialisasiMitra;

  @JsonKey(name: 'is_sosialisasi_mitra')
  final String isSosialisasiMitra;

  @JsonKey(name: 'sosialisasi_stakeholder')
  final String sosialisasiStake;

  @JsonKey(name: 'is_sosialisasi_stakeholder')
  final String isSosialisasiStake;

  @JsonKey(name: 'campaign')
  final String campaign;

  @JsonKey(name: 'is_campaign')
  final String isCampaign;

  @JsonKey(name: 'review')
  final String review;

  @JsonKey(name: 'review_file')
  final String reviewFile;

  @JsonKey(name: 'is_review')
  final String isReview;

  @JsonKey(name: 'keterangan')
  final String keterangan;

  CovidDetail({
   this.idAngka, this.isSopStakeholder, this.lastUpdate,
    this.namaLengkap, this.id, this.keterangan, this.campaign, this.grandTotal, this.grandTotalColor, this.isCampaign, this.isReview, this.isSopKaryawan, this.isSopMitra, this.isSopPelanggan, this.isSopSupplier,
    this.isSosialisasi, this.isSosialisasiMitra, this.isSosialisasiplgn, this.isSosialisasiStake, this.isSosialisasiSupplier, this.isTaskForce,
    this.jumlahProtokol,this.jumlahProtokolColor, this.jumlahSosialisasi, this.jumlahTaskforce, this.jumlahTaskforceColor, this.review, this.reviewFile,
    this.sopKaryawan, this.sopMitra, this.sopPelanggan, this.sopStakeholder, this.sopSupplier, this.sosialisasi, this.sosialisasiMitra, this.sosialisasiplgn,
    this.sosialisasiStake, this.sosialisasiSupplier, this.taskForce
  });

  factory CovidDetail.fromJson(Map<String, dynamic> json) =>
      _$CovidDetailFromJson(json);

  static get serializer => _$CovidDetailFromJson;

}