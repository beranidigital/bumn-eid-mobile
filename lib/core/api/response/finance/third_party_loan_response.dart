import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/finance/third_party_loan.dart';
import 'package:json_annotation/json_annotation.dart';

part 'third_party_loan_response.g.dart';

@JsonSerializable(createToJson: false)
class ThirdPartyLoanResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final List<ThirdPartyLoan> companies;

  ThirdPartyLoanResponse({this.success, this.message, this.companies});

  factory ThirdPartyLoanResponse.fromJson(Map<String, dynamic> json) =>
      _$ThirdPartyLoanResponseFromJson(json);

  static get serializer => _$ThirdPartyLoanResponseFromJson;
}