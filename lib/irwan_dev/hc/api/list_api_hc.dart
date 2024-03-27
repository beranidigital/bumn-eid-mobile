import 'dart:convert';
import 'dart:core';

import 'package:bumn_eid/irwan_dev/hc/models/bumn_list.dart';
import 'package:bumn_eid/irwan_dev/hc/models/count_perusahaan.dart';
import 'package:bumn_eid/irwan_dev/hc/models/detail_bumn_talent.dart';
import 'package:bumn_eid/irwan_dev/hc/models/filter_talent.dart';
import 'package:bumn_eid/irwan_dev/hc/models/hc_main_page.dart';
import 'package:bumn_eid/irwan_dev/hc/models/list_company_talent_pool.dart';
import 'package:bumn_eid/irwan_dev/hc/models/list_talent_pool.dart';
import 'package:bumn_eid/irwan_dev/hc/models/profil_detail_detail_bumn.dart';
import 'package:bumn_eid/irwan_dev/hc/models/profil_detail_summary_bumn.dart';
import 'package:bumn_eid/irwan_dev/hc/models/profil_pejabat_model.dart';
import 'package:bumn_eid/irwan_dev/hc/models/profil_talent_pool.dart';
import 'package:bumn_eid/irwan_dev/hc/models/talent_pool_summary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:bumn_eid/irwan_dev/hc/resources/const.dart';

class ListApiHC {
  Future<HCMainPage> getSummaryDashboardHC(String path) async {
    final response =
        await http.get("${Const.preferedUrl}/hc?$path", headers: Const.headers);

    print(response.request.toString());

    if (response.statusCode == 200) {
      var jsonObject = json.decode(response.body);
      var dataValue = (jsonObject as Map<String, dynamic>)['data'];

      return new HCMainPage.fromMap(dataValue);
    } else {
      // dialogProblem();
    }
  }

  Future<Map<String, dynamic>> getDataBOC(String end_point_params) async {
    print(end_point_params);
    final response = await http.get(
        "${Const.preferedUrl}/hc/boc?$end_point_params",
        headers: Const.headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonObject = json.decode(response.body);
      var dataValue = (jsonObject as Map<String, dynamic>)['data'];

      return dataValue;
    } else {
      // dialogProblem();
    }
  }

  Future<Map<String, dynamic>> getDataFilterBOC() async {
    final response = await http.get("${Const.preferedUrl}/hc/boc/filters",
        headers: Const.headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonObject = json.decode(response.body);
      var dataValue = (jsonObject as Map<String, dynamic>)['data'];

      // listData.add(SummaryJenisKegiatan.fromMap(dataValue[i]));
      // print(dataValue.toString());

      return dataValue;
    } else {
      // dialogProblem();
    }
  }

  Future<Map<String, dynamic>> getDataFilterDashboard() async {
    final response = await http.get("${Const.preferedUrl}/hc/filters",
        headers: Const.headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonObject = json.decode(response.body);
      var dataValue = (jsonObject as Map<String, dynamic>)['data'];

      // listData.add(SummaryJenisKegiatan.fromMap(dataValue[i]));
      // print(dataValue.toString());

      return dataValue;
    } else {
      // dialogProblem();
    }
  }

  Future<Map<String, dynamic>> getDataFilterTalent() async {
    final response = await http.get("${Const.preferedUrl}/hc/talent/filters",
        headers: Const.headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonObject = json.decode(response.body);
      var dataValue = (jsonObject as Map<String, dynamic>)['data'];

      return dataValue;
    } else {
      Map<String, dynamic> dataValue = {
        "jenis_kelamin": [],
        "agama": [],
        "masa_jabat": [],
        "wamen_bumn": [],
        "kelas_bumn": [],
        "cluster_bumn": [],
      };
      return dataValue;
      // dialogProblem();
    }
  }

  Future<Map<String, dynamic>> getDataFilterBOD() async {
    final response = await http.get("${Const.preferedUrl}/hc/bod/filters",
        headers: Const.headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonObject = json.decode(response.body);
      var dataValue = (jsonObject as Map<String, dynamic>)['data'];

      // listData.add(SummaryJenisKegiatan.fromMap(dataValue[i]));
      // print(dataValue.toString());

      return dataValue;
    } else {
      // dialogProblem();
    }
  }

  Future<Map<String, dynamic>> getDataFilterPerusahaan() async {
    final response = await http.get("${Const.preferedUrl}/hc/bumn/filters",
        headers: Const.headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonObject = json.decode(response.body);
      var dataValue = (jsonObject as Map<String, dynamic>)['data'];

      // listData.add(SummaryJenisKegiatan.fromMap(dataValue[i]));
      // print(dataValue.toString());

      return dataValue;
    } else {
      // dialogProblem();
    }
  }

  Future<Map<String, dynamic>> getDataInduk(String path) async {
    final response =
        await http.get("${Const.preferedUrl}/hc/$path", headers: Const.headers);

    print(response.request.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonObject = json.decode(response.body);
      var dataValue = (jsonObject as Map<String, dynamic>)['data']['summary'];

      // listData.add(SummaryJenisKegiatan.fromMap(dataValue[i]));
      // print(dataValue.toString());

      return dataValue;
    } else {
      // dialogProblem();
    }
  }

  Future<List<DetailBUMNTalent>> getDataListTalenta(String path) async {
    final response =
        await http.get("${Const.preferedUrl}/hc/$path", headers: Const.headers);

    print(response.request.toString());
    if (response.statusCode == 200) {
      var jsonObject = json.decode(response.body);
      var dataValue = (jsonObject as Map<String, dynamic>)['data']['list'];

      List<DetailBUMNTalent> listData = [];
      for (int i = 0; i < dataValue.length; i++) {
        listData.add(new DetailBUMNTalent.fromMap(dataValue[i]));
      }

      return listData;
    } else {
      // dialogProblem();
    }
  }

  Future<Map<String, dynamic>> getDataBOCInduk() async {
    final response =
        await http.get("${Const.preferedUrl}/hc/boc", headers: Const.headers);

    if (response.statusCode == 200) {
      var jsonObject = json.decode(response.body);
      var dataValue = (jsonObject as Map<String, dynamic>)['data'];

      // listData.add(SummaryJenisKegiatan.fromMap(dataValue[i]));

      return dataValue;
    } else {
      // dialogProblem();
    }
  }

  Future<ListTalentPool> getListTalentPool(String endPoint) async {
    final response = await http.get(
        // "https://eid.bumn.go.id/hc/talent/show/detail/talentPool/by/all/all",
        "${Const.preferedUrl}/hc/talent?$endPoint",
        headers: Const.headers);

    print(response.request);

    if (response.statusCode == 201 || response.statusCode == 200) {
      var jsonObject = json.decode(response.body);
      var dataValue = (jsonObject as Map<String, dynamic>)['data'];

      return new ListTalentPool.fromMap(dataValue);
    } else {
      return new ListTalentPool();
      // dialogProblem();
    }
  }

  Future<ProfileTalentPool> getDetailTalent(String nik) async {
    final response = await http.get("https://eid.bumn.go.id/api/hc/talent/$nik",
        headers: Const.headers);

    print(response.request.toString());

    if (response.statusCode == 201 || response.statusCode == 200) {
      var jsonObject = json.decode(response.body);
      var dataValue = (jsonObject as Map<String, dynamic>)['data'];

      return new ProfileTalentPool.fromMap(dataValue);
    } else {
      return new ProfileTalentPool();
    }
  }

  Future<ProfilPejabatModel> getProfilPejabat(
      String id_talent, BuildContext context) async {
    final response = await http.get(
        "${Const.preferedUrl}/hc/pejabat/$id_talent",
        headers: Const.headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonObject = json.decode(response.body);
      var dataValue = (jsonObject as Map<String, dynamic>)['data'];

      return new ProfilPejabatModel.fromMap(dataValue);
    } else {
      dialogProblem(context);
    }
  }

  Future<BUMNListPagination> getBUMNList(String path) async {
    final response = await http.get("${Const.preferedUrl}/hc/bumn/$path",
        headers: Const.headers);

    print(response.request.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonObject = json.decode(response.body);
      var dataValue = (jsonObject as Map<String, dynamic>);

      return new BUMNListPagination.fromMap(dataValue);
      // return "okee";
    } else {
      return new BUMNListPagination(current_page: 1, last_page: 1, data: []);
      // dialogProblem();
    }
  }

  Future<CountPerusahaan> getCountPerusahaan() async {
    final response = await http.get("${Const.preferedUrl}/hc/bumn/summary",
        headers: Const.headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonObject = json.decode(response.body);
      var dataValue = (jsonObject as Map<String, dynamic>)['data'];

      return CountPerusahaan.fromMap(dataValue);
      // return "okee";
    } else {
      // dialogProblem();
    }
  }

  Future<Map<String, dynamic>> getBUMNProfiles(String idBumn) async {
    final response = await http.get("${Const.preferedUrl}/hc/bumn/$idBumn",
        headers: Const.headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonObject = json.decode(response.body);
      var dataValue =
          (jsonObject as Map<String, dynamic>)['data']['bumn_profiles'];

      return dataValue;
    } else {
      Map<String, dynamic> bumn = {
        "name": [],
        "logo": [],
      };
      return bumn;
      // dialogProblem();
    }
  }

  Future<TalentPoolSummary> getSummaryTalentPool(String path) async {
    final response = await http.get("${Const.preferedUrl}/hc/talent?$path",
        headers: Const.headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonObject = json.decode(response.body);
      var dataValue = (jsonObject as Map<String, dynamic>)['data']['summary'];

      // return TalentPoolSummary.fromMap(dataValue);
      return TalentPoolSummary.fromMap(dataValue);
    } else {
      // dialogProblem();
    }
  }

  Future<SummaryProfilBUMN> getSummaryBUMNProfiles(String idBumn) async {
    final response = await http.get("${Const.preferedUrl}/hc/bumn/$idBumn",
        headers: Const.headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonObject = json.decode(response.body);
      var dataValue = (jsonObject as Map<String, dynamic>)['data']['summary'];

      return new SummaryProfilBUMN.fromMap(dataValue);
    } else {
      return new SummaryProfilBUMN();
    }
  }

  Future<DetailProfilBUMN> getDetailBUMNProfiles(String idBumn) async {
    final response = await http.get("${Const.preferedUrl}/hc/bumn/$idBumn",
        headers: Const.headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonObject = json.decode(response.body);
      var dataValue = (jsonObject as Map<String, dynamic>)['data']['detail'];

      return new DetailProfilBUMN.fromMap(dataValue);
    } else {
      return new DetailProfilBUMN();
    }
  }

  static dialogProblem(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text(
          'Server Bermasalah',
          textAlign: TextAlign.center,
        ),
        content: Text(
          'Thanks for your report!',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
