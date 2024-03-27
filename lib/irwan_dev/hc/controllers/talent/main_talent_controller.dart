import 'package:bumn_eid/irwan_dev/hc/models/filter_talent.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainTalentController extends GetxController {
  int choiceView = 0;

  void setChoiceViewNotRefresh(int val) {
    choiceView = val;
  }

  void setChoiceView(val) {
    choiceView = val;
    update(['mainTalent']);
  }

  int limitVal = 3;

  void setLimitVal(int val) {
    limitVal += val;
    update(['refreshListTalent']);
  }

  int modeStatus = 0;

  void setModeStatus(int val) {
    modeStatus = val;
  }

  void refreshListTalent() {
    update(['refreshListTalent']);
  }

  int kodePencarian = 0;

  void setKodePencarian(int val) {
    kodePencarian = val;
    update(['dropDown']);
  }

  List<IconData> iconFilter = [Icons.filter_list];
  List<String> titleFilter = ["Filter"];

  void setDataFilter(List<IconData> lsIcon, List<String> lsTitle) {
    iconFilter = lsIcon;
    titleFilter = lsTitle;
  }

  String path = "";
  void updateFilter(List<IconData> lsIcon, List<String> lsTitle, String val) {
    iconFilter.addAll(lsIcon);
    titleFilter.addAll(lsTitle);
    path = val;
    update(['mainTalent']);
  }

  void refreshFilter() {
    update(['refreshFilter']);
  }

  Map<String, dynamic> dataList = new Map<String, dynamic>().obs;

  void setListDataObs(Map<String, dynamic> data) {
    dataList = data;
  }

  String jk = "";
  String agama = "";
  String wamen = "";
  String kelas = "";
  String cluster = "";
  String statusTalent = "";
  String kelompokUsia = "";
  String valKelompokUsia = "";
  String masaJabat = "";
  String valMasaJabat = "";

  void setResetFilter() {
    jk = "";
    agama = "";
    wamen = "";
    kelas = "";
    cluster = "";
    statusTalent = "";
    kelompokUsia = "";
    valKelompokUsia = "";
    masaJabat = "";
    valMasaJabat = "";
  }

  set setJk(String value) => this.jk = value;
  set setWamen(String value) => this.wamen = value;
  set setKelas(String value) => this.kelas = value;
  set setCluster(String value) => this.cluster = value;
  set setAgama(String value) => this.agama = value;
  set setStatusTalent(String value) => this.statusTalent = value;
  set setKelompokUsia(String value) => this.kelompokUsia = value;
  set setValKelompokUsia(String value) => this.valKelompokUsia = value;
  set setMasaJabat(String value) => this.masaJabat = value;
  set setValMasaJabat(String value) => this.valMasaJabat = value;

  void refreshDropDown() {
    update(['dropDown']);
  }
}
