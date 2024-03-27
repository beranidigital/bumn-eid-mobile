import 'dart:convert';

import 'package:bumn_eid/irwan_dev/padi/resources/const.dart';
import 'package:http/http.dart' as http;

class AllApi {
  static get json => null;

  static Future<Map<String, dynamic>> getDataSummary() async {
    final response =
        await http.get('${Const.baseUrl}/api/padi', headers: Const.headers);

    if (response.statusCode == 200) {
      // print(response.statusCode);
      var json_decode = jsonDecode(response.body)['data'];
      // var dataValue = (json_decode as Map<String, dynamic>);
      return json_decode;
    } else {
      // throw Exception('Masalah Pada Web Server');
    }
  }

  static Future<Map<String, dynamic>> getData() async {
    final response =
        await http.get('${Const.baseUrl}/api/padi', headers: Const.headers);

    if (response.statusCode == 200) {
      // print(response.statusCode);
      var json_decode = jsonDecode(response.body)['data'];
      // var dataValue = (json_decode as Map<String, dynamic>);
      return json_decode;
    } else {
      // throw Exception('Masalah Pada Web Server');
    }
  }
}
