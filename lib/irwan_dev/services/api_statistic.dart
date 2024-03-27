import 'dart:convert';

import 'package:bumn_eid/irwan_dev/cosmics/resources/value_const.dart';
import 'package:bumn_eid/irwan_dev/services/storage_preferences.dart';
import 'package:http/http.dart' as http;

class ApiStatistic {
  Future<http.Response> insertStatistic(String ket_fitur, String keterangan) {
    try {
      return http.post(
        "https://eid.bumn.go.id/app/statistic",
        body: {
          "id_user": "${StoragePreferences.getIdUser()}",
          "ket_fitur": ket_fitur,
          "keterangan": keterangan,
        },
      );
    } on Exception catch (e) {
      print("Login Gagal");
    }
  }
}
