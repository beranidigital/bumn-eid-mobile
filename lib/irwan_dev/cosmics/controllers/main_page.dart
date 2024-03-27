import 'package:get/get.dart';

class MainPageController extends GetxController {
  //filter menu
  int groupValueData = 0;
  int groupValueTotal = 0;
  String cluster = "Adakah 1";
  String waktu = "2020";
  String wamen = "2020";
  String classs = "2020";

  void setGroupValueData(int val) {
    groupValueData = val;
    update();
  }

  void setGroupValueTotal(int val) {
    groupValueTotal = val;
    update();
  }

  void setCluster(String val) {
    cluster = val;
    update();
  }

  void setWaktu(String val) {
    waktu = val;
    update();
  }

  void setWamen(String val) {
    wamen = val;
    update();
  }

  void setClass(String val) {
    classs = val;
    update();
  }

  void setUpdate() {
    update();
  }
}
