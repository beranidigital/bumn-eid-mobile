import 'dart:convert';

import 'package:bumn_eid/irwan_dev/cosmics/models/detail_list_bumn.dart';
import 'package:bumn_eid/irwan_dev/cosmics/models/detail_model/summary_all.dart';
import 'package:bumn_eid/irwan_dev/cosmics/models/list_bumn.dart';
import 'package:bumn_eid/irwan_dev/cosmics/models/list_event.dart';
import 'package:bumn_eid/irwan_dev/cosmics/models/list_vaksinasi.dart';
import 'package:bumn_eid/irwan_dev/cosmics/models/parimeter_bumn.dart';
import 'package:bumn_eid/irwan_dev/cosmics/models/parimeter_kategori.dart';
import 'package:bumn_eid/irwan_dev/cosmics/models/parimeter_provinsi.dart';
import 'package:bumn_eid/irwan_dev/cosmics/models/summary_jenis_kegiatan.dart';
import 'package:bumn_eid/irwan_dev/cosmics/models/summary_main_page_1.dart';
import 'package:bumn_eid/irwan_dev/cosmics/models/terdampak_bumn.dart';
import 'package:bumn_eid/irwan_dev/cosmics/models/terdampak_kabupaten.dart';
import 'package:bumn_eid/irwan_dev/cosmics/models/terdampak_provinsi.dart';
import 'package:bumn_eid/irwan_dev/cosmics/resources/value_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:bumn_eid/irwan_dev/cosmics/models/detail_model/detail_list_bumn.dart';

class ListApi {
  static Future<SummaryMainPage1> getDataSummary1() async {
    final response = await http.get(
        'https://eid.bumn.go.id/api/cosmics/summary',
        headers: ValueConst.headers);

    if (response.statusCode == 200) {
      var jsonObject = json.decode(response.body);
      var dataValue = (jsonObject as Map<String, dynamic>)['data'];
      // var data = (dataValue['summary_all'] as List<dynamic>);

      List<SummaryAll> _summaryAll = [];
      _summaryAll.add(SummaryAll.fromMap(dataValue['summary_all']));

      // List<SummaryPerkembanganKasus> _summaryPerkembanganKasus = [];
      // _summaryPerkembanganKasus.add(SummaryPerkembanganKasus.fromMap(
      //     dataValue['summary_perkembanganKasus']));

      var summaryMainPage = SummaryMainPage1(summaryAll: _summaryAll);
      //     summaryPerkembanganKasus: _summaryPerkembanganKasus);

      return summaryMainPage;
    } else {
      // throw Exception('Masalah Pada Web Server');
      dialogProblem();
    }
  }

  static Future<List<ListBumn>> getDataAllListBumn() async {
    final response = await http.get('https://eid.bumn.go.id/api/cosmics',
        headers: ValueConst.headers);

    if (response.statusCode == 200) {
      var jsonObject = json.decode(response.body);
      var dataValue = (jsonObject as Map<String, dynamic>)['data'];

      List<ListBumn> listData = [];
      for (int i = 0; i < dataValue.length; i++) {
        listData.add(ListBumn.fromMap(dataValue[i]));
      }

      return listData;
    } else {
      dialogProblem();
    }
  }

  static Future<List<TerdampakBumn>> getAllListBumnTerdampak() async {
    final response = await http.get(
        "https://eid.bumn.go.id/api/cosmics/terdampak",
        headers: ValueConst.headers);

    if (response.statusCode == 200) {
      var jsonObject = json.decode(response.body);
      var dataValue = (jsonObject as Map<String, dynamic>)['data'];

      List<TerdampakBumn> listData = [];
      for (int i = 0; i < dataValue.length; i++) {
        listData.add(TerdampakBumn.fromMap(dataValue[i]));
      }

      return listData;
    } else {
      dialogProblem();
    }
  }

  static Future<List<TerdampakProvinsi>> getAllListProvinsiTerdampak() async {
    final response = await http.get(
        "https://eid.bumn.go.id/api/cosmics/terdampak/provinsi",
        headers: ValueConst.headers);

    if (response.statusCode == 200) {
      var jsonObject = json.decode(response.body);
      var dataValue = (jsonObject as Map<String, dynamic>)['data'];

      List<TerdampakProvinsi> listData = [];
      for (int i = 0; i < dataValue.length; i++) {
        listData.add(TerdampakProvinsi.fromMap(dataValue[i]));
      }

      return listData;
    } else {
      dialogProblem();
    }
  }

  static Future<List<TerdampakKabupaten>> getAllListKabupatenTerdampak() async {
    final response = await http.get(
        "https://eid.bumn.go.id/api/cosmics/terdampak/kabupaten",
        headers: ValueConst.headers);

    if (response.statusCode == 200) {
      var jsonObject = json.decode(response.body);
      var dataValue = (jsonObject as Map<String, dynamic>)['data'];

      List<TerdampakKabupaten> listData = [];
      for (int i = 0; i < dataValue.length; i++) {
        listData.add(TerdampakKabupaten.fromMap(dataValue[i]));
      }

      return listData;
    } else {
      dialogProblem();
    }
  }

  static Future getSummaryVaksin() async {
    final response = await http.get(
        "https://eid.bumn.go.id/api/cosmics/vaksin/summary",
        headers: ValueConst.headers);

    if (response.statusCode == 200) {
      var jsonObject = json.decode(response.body);
      var dataValue = (jsonObject as Map<String, dynamic>)['data'];

      return dataValue['summary_all'];
    } else {
      dialogProblem();
    }
  }

  static Future<List<ListVaksinasi>> getDataVaksinasi() async {
    final response = await http.get("https://eid.bumn.go.id/api/cosmics/vaksin",
        headers: ValueConst.headers);

    if (response.statusCode == 200) {
      var jsonObject = json.decode(response.body);
      var dataValue = (jsonObject as Map<String, dynamic>)['data'];

      List<ListVaksinasi> listData = [];
      for (int i = 0; i < dataValue.length; i++) {
        listData.add(ListVaksinasi.fromMap(dataValue[i]));
      }

      return listData;
    } else {
      dialogProblem();
    }
  }

  static Future getSummaryParimeter() async {
    final response = await http.get(
        "https://eid.bumn.go.id/api/cosmics/perimeter/summary",
        headers: ValueConst.headers);

    if (response.statusCode == 200) {
      var jsonObject = json.decode(response.body);
      var dataValue = (jsonObject as Map<String, dynamic>)['data'];

      return dataValue['summary_all'];
    } else {
      dialogProblem();
    }
  }

  static Future<List<ParimeterBumn>> getDataParimeterBumn() async {
    final response = await http.get(
        "https://eid.bumn.go.id/api/cosmics/perimeter",
        headers: ValueConst.headers);

    if (response.statusCode == 200) {
      var jsonObject = json.decode(response.body);
      var dataValue = (jsonObject as Map<String, dynamic>)['data'];

      List<ParimeterBumn> listData = [];
      for (int i = 0; i < dataValue.length; i++) {
        listData.add(ParimeterBumn.fromMap(dataValue[i]));
      }

      return listData;
    } else {
      dialogProblem();
    }
  }

  static Future<List<ParimeterProvinsi>> getDataParimeterProvinsi() async {
    final response = await http.get(
        "https://eid.bumn.go.id/api/cosmics/perimeter/provinsi",
        headers: ValueConst.headers);

    if (response.statusCode == 200) {
      var jsonObject = json.decode(response.body);
      var dataValue = (jsonObject as Map<String, dynamic>)['data'];

      List<ParimeterProvinsi> listData = [];
      for (int i = 0; i < dataValue.length; i++) {
        listData.add(ParimeterProvinsi.fromMap(dataValue[i]));
      }

      return listData;
    } else {
      dialogProblem();
    }
  }

  static Future<List<ParimeterKategori>> getDataParimeterKategori() async {
    final response = await http.get(
        "https://eid.bumn.go.id/api/cosmics/perimeter/kategori",
        headers: ValueConst.headers);

    if (response.statusCode == 200) {
      var jsonObject = json.decode(response.body);
      var dataValue = (jsonObject as Map<String, dynamic>)['data'];

      List<ParimeterKategori> listData = [];
      for (int i = 0; i < dataValue.length; i++) {
        listData.add(ParimeterKategori.fromMap(dataValue[i]));
      }

      return listData;
    } else {
      dialogProblem();
    }
  }

  static Future<List<ParimeterBumn>> getDetailParimeterBumn(String url) async {
    final response = await http.get(url, headers: ValueConst.headers);

    if (response.statusCode == 200) {
      var jsonObject = json.decode(response.body);
      var dataValue = (jsonObject as Map<String, dynamic>)['data'];

      List<ParimeterBumn> listData = [];
      for (int i = 0; i < dataValue.length; i++) {
        listData.add(ParimeterBumn.fromMap(dataValue[i]));
      }

      return listData;
    } else {
      dialogProblem();
    }
  }

  static Future getSummaryTerdampak() async {
    final response = await http.get(
        "https://eid.bumn.go.id/api/cosmics/terdampak/summary",
        headers: ValueConst.headers);

    if (response.statusCode == 200) {
      var jsonObject = json.decode(response.body);
      var dataValue = (jsonObject as Map<String, dynamic>)['data'];

      return dataValue['summary_all'];
    } else {
      dialogProblem();
    }
  }

  static Future<List<TerdampakBumn>> getDetailTerdampakBumn(String url) async {
    final response = await http.get(url, headers: ValueConst.headers);

    if (response.statusCode == 200) {
      var jsonObject = json.decode(response.body);
      var dataValue = (jsonObject as Map<String, dynamic>)['data'];

      List<TerdampakBumn> listData = [];
      for (int i = 0; i < dataValue.length; i++) {
        listData.add(TerdampakBumn.fromMap(dataValue[i]));
      }

      return listData;
    } else {
      dialogProblem();
    }
  }

  static Future<DetailListBumn> getDetailDataBumn(String id) async {
    final response = await http.get('https://eid.bumn.go.id/api/cosmics/$id',
        headers: ValueConst.headers);

    if (response.statusCode == 200) {
      var jsonObject = json.decode(response.body);
      var dataValue = (jsonObject as Map<String, dynamic>)['data'];
      // print("bumn_profiles : ${dataValue['bumn_profiles']}");
      // print("summary : ${dataValue['summary']}");
      // print("perkembangan kasus : ${dataValue['perkembangan_kasus']}");
      // print("progress vaksin : ${dataValue['progress_vaksin']}");
      // print(
      //     "covidsafe protokol : ${dataValue['covidsafe_protokol'].runtimeType}");
      // print("cosmic index : ${dataValue['cosmic_index']}");
      // print("pegawai_terdampak : ${dataValue['pegawai_terdampak']}");
      // print("events : ${dataValue['events']}");
      // print("kategori perimeters : ${dataValue['kategori_perimeters']}");
      // var data = (dataValue['summary_all'] as List<dynamic>);

      List<BumnProfiles> _bumnProfiles = [];
      _bumnProfiles.add(BumnProfiles.fromMap(dataValue['bumn_profiles']));

      List<Summary> _summary = [];
      _summary.add(Summary.fromMap(dataValue['summary_all']));

      List<SumPerkembanganKasus> _summaryPerkembanganKasus = [];
      _summaryPerkembanganKasus.add(SumPerkembanganKasus.fromMap(
          dataValue['summary_perkembangan_kasus']));

      List<SummaryProgressVaksin> _summaryProgressVaksin = [];
      _summaryProgressVaksin.add(
          SummaryProgressVaksin.fromMap(dataValue['summary_progress_vaksin']));

      List<CovidSafeProtokol> _covidSafeProtokol = [];
      for (int i = 0; i < dataValue['covidsafe_protokol'].length; i++) {
        _covidSafeProtokol
            .add(CovidSafeProtokol.fromMap(dataValue['covidsafe_protokol'][i]));
      }

      Map<String, dynamic> _nullValidationSafety = {
        'perkembangan_kasus': [
          {
            "status_kasus2": "-",
            "total": "-",
          },
        ],
      };
      List<PerkembanganKasus> _perkembangan_kasus = [];
      _perkembangan_kasus.add(PerkembanganKasus.fromMap(
          dataValue['perkembangan_kasus'][0] ?? _nullValidationSafety));

      List<CosmicIndex> _cosmicIndex = [];
      for (int i = 0; i < dataValue['cosmic_index'].length; i++) {
        _cosmicIndex.add(CosmicIndex.fromMap(dataValue['cosmic_index'][i]));
      }

      List<PegawaiTerdampak> _pegawaiTerdampak = [];
      for (int i = 0; i < dataValue['pegawai_terdampak'].length; i++) {
        _pegawaiTerdampak
            .add(PegawaiTerdampak.fromMap(dataValue['pegawai_terdampak'][i]));
      }

      List<Events> _events = [];
      for (int i = 0; i < dataValue['events'].length; i++) {
        _events.add(Events.fromMap(dataValue['events'][i]));
      }

      List<KategoriPerimeters> _kategoriPerimeters = [];
      for (int i = 0; i < dataValue['kategori_perimeters'].length; i++) {
        _kategoriPerimeters.add(
            KategoriPerimeters.fromMap(dataValue['kategori_perimeters'][i]));
      }

      var detailListBumn = DetailListBumn(
          bumn_profiles: _bumnProfiles,
          events: _events,
          cosmic_index: _cosmicIndex,
          kategori_perimeters: _kategoriPerimeters,
          pegawai_terdampak: _pegawaiTerdampak,
          perkembangan_kasus: _perkembangan_kasus,
          covidSafeProtokol: _covidSafeProtokol,
          summaryPerkembanganKasus: _summaryPerkembanganKasus,
          summaryProgressVaksin: _summaryProgressVaksin,
          summary: _summary);

      return detailListBumn;
    } else {
      dialogProblem();
    }
  }

  static Future<List<ListEvent>> getDataEvent() async {
    final response = await http.get(
        "https://eid.bumn.go.id/api/cosmics/sosialisasi",
        headers: ValueConst.headers);

    if (response.statusCode == 200) {
      var jsonObject = json.decode(response.body);
      var dataValue = (jsonObject as Map<String, dynamic>)['data'];

      List<ListEvent> listData = [];
      for (int i = 0; i < dataValue.length; i++) {
        listData.add(ListEvent.fromMap(dataValue[i]));
      }

      return listData;
    } else {
      dialogProblem();
    }
  }

  static Future<List<SummaryJenisKegiatan>> getSummaryJenisKegiatan() async {
    final response = await http.get(
        "https://eid.bumn.go.id/api/cosmics/sosialisasi/summary",
        headers: ValueConst.headers);

    if (response.statusCode == 200) {
      var jsonObject = json.decode(response.body);
      var dataValue = (jsonObject as Map<String, dynamic>)['data']
          ['summary_all']['jenis_kegiatan'];

      List<SummaryJenisKegiatan> listData = [];
      for (int i = 0; i < dataValue.length; i++) {
        listData.add(SummaryJenisKegiatan.fromMap(dataValue[i]));
      }

      return listData;
    } else {
      dialogProblem();
    }
  }

  static dialogProblem() {
    print("Server Bermasalah");
    // Get.defaultDialog(
    //   title: "Server Bermasalah!!",
    //   content: (Container(
    //     child: Text("Mohon Tunggu....."),
    //   )),
    // );
  }
}
