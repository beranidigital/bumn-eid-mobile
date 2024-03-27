import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainBodController extends GetxController {
  int choiceView = 0;

  void setVoiceView(val) {
    choiceView = val;
    update(['mainBod']);
  }

  int top10Kondisi = 0;

  void settop10Kondisi(val) {
    top10Kondisi = val;
    update(['top10Kondisi']);
  }

  int top10Ormas = 0;

  void settop10Ormas(val) {
    top10Ormas = val;
    update(['top10Ormas']);
  }

  int limitVal = 40;

  void setLimitVal(int val) {
    limitVal += val;
    update(['refreshList']);
  }

  void refreshList() {
    update(['refreshList']);
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
    update(['mainBod']);
  }

  void refreshFilter() {
    update(['refreshFilter']);
  }

  Map<String, dynamic> listData = new Map<String, dynamic>().obs;

  void setListDataObs(Map<String, dynamic> dataList) {
    listData = dataList;
  }

  String asalInstansi = "";
  String gender = "";
  String kelas = "";
  String wamen = "";
  String cluster = "";

  void setResetFilter() {
    asalInstansi = "";
    gender = "";
    kelas = "";
    wamen = "";
    cluster = "";
  }

  set setAsalInstansi(String value) => this.asalInstansi = value;
  set setGender(String value) => this.gender = value;
  set setKelas(String value) => this.kelas = value;
  set setWamen(String value) => this.wamen = value;
  set setCluster(String value) => this.cluster = value;
}
