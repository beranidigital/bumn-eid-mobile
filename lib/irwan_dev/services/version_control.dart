import 'dart:convert';
import 'dart:io';

import 'package:bumn_eid/irwan_dev/cosmics/resources/value_const.dart';
import 'package:bumn_eid/irwan_dev/services/storage_preferences.dart';
import 'package:http/http.dart' as http;

class ModelVersionControl {
  String ket_platform;
  String version;
  String version_code;
  ModelVersionControl({
    this.ket_platform,
    this.version,
    this.version_code,
  });

  Map<String, dynamic> toMap() {
    return {
      'ket_platform': ket_platform,
      'version': version,
      'version_code': version_code,
    };
  }

  factory ModelVersionControl.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ModelVersionControl(
      ket_platform: map['ket_platform'],
      version: map['version'],
      version_code: map['version_code'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelVersionControl.fromJson(String source) =>
      ModelVersionControl.fromMap(json.decode(source));
}

class VersionControl {
  Future<ModelVersionControl> getVersionControl() async {
    String statusPlatform = (Platform.isAndroid) ? "Android" : "ios";

    try {
      final response = await http.get('https://eid.bumn.go.id/app/get/version',
          headers: ValueConst.headers);

      // Tersedia Versi Terbaru (Beta Version)

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonObject = json.decode(response.body);
        var dataValue = (jsonObject as Map<String, dynamic>)['data'];

        ModelVersionControl _listModel = new ModelVersionControl();
        for (int i = dataValue.length - 1; i >= 0; i--) {
          if (dataValue[i]['ket_platform'] == statusPlatform) {
            _listModel = new ModelVersionControl(
                version: dataValue[i]['version'],
                ket_platform: dataValue[i]['ket_platform'],
                version_code: dataValue[i]['version_code']);
          }
        }

        StoragePreferences.setVersionApps(_listModel.version.toString());

        return _listModel;
      }
    } on Exception catch (e) {
      print("Login Gagal");
    }
  }
}
