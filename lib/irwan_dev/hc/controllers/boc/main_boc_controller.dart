import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainBocController extends GetxController {
  int choiceView = 0;

  void setChoiceView(val) {
    choiceView = val;
    update(['mainBoc']);
  }

  int choiceTop10 = 0;

  void setChoiceTop10(val) {
    choiceTop10 = val;
    update(['top10Boc']);
  }

  int choiceOrmas = 0;

  void setChoiceOrmas(val) {
    choiceOrmas = val;
    update(['topOrmas']);
  }

  int limitVal = 30;

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
    update(['mainBoc']);
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
