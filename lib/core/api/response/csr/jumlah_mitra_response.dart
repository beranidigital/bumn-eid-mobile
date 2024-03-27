import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/csr/jumlah_mitra.dart';
import 'package:json_annotation/json_annotation.dart';

part 'jumlah_mitra_response.g.dart';

@JsonSerializable(createToJson: false)
class JumlahMitraResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final List<JumlahMitra> data;


  JumlahMitraResponse({this.success, this.message, this.data});

  factory JumlahMitraResponse.fromJson(Map<String, dynamic> json) =>
      _$JumlahMitraResponseFromJson(json);

  static get serializer => _$JumlahMitraResponseFromJson;
}