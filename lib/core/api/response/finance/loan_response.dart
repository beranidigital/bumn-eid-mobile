import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/finance/loan.dart';
import 'package:json_annotation/json_annotation.dart';

part 'loan_response.g.dart';

@JsonSerializable(createToJson: false)
class LoanResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final List<Loan> companies;

  LoanResponse({this.success, this.message, this.companies});

  factory LoanResponse.fromJson(Map<String, dynamic> json) =>
      _$LoanResponseFromJson(json);

  static get serializer => _$LoanResponseFromJson;
}