import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/common/anak_perusahaan_deni.dart';
import 'package:bumn_eid/core/models/internal/employee.dart';
import 'package:bumn_eid/core/models/internal/summary_internal.dart';
import 'package:json_annotation/json_annotation.dart';

part 'employee_response.g.dart';

@JsonSerializable(createToJson: false)
class EmployeeResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'current_page')
  final int currentPage;

  @JsonKey(name: 'data')
  final List<Employee> data;

  EmployeeResponse({
    this.success,
    this.message,
    this.currentPage,
    this.data,
  });

  factory EmployeeResponse.fromJson(Map<String, dynamic> json) =>
      _$EmployeeResponseFromJson(json);

  static get serializer => _$EmployeeResponseFromJson;
}
