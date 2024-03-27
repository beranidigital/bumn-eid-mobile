import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/business_portfolio/profil_perusahaan.dart';
import 'package:bumn_eid/core/utils/constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'local_companies.g.dart';

@JsonSerializable()
class LocalCompanies extends ResponseObject {

  @JsonKey(name: 'companies')
  final List<ProfilPerusahaan> companies;

  @JsonKey(name: 'saved_time')
  final DateTime savedTime;

  LocalCompanies({
    this.companies,
    this.savedTime,
  });

  factory LocalCompanies.fromJson(Map<String, dynamic> json) =>
      _$LocalCompaniesFromJson(json);

  static get serializer => _$LocalCompaniesFromJson;

  Map toJson() {
    return _$LocalCompaniesToJson(this);
  }

  bool checkIfStillEligible() {
    final now = DateTime.now();
    final diff = now.difference(savedTime);
    return diff.inHours < Constants.maxSavedDataInHrs;
  }

}