import 'package:get/get.dart';

class MainParimeterController extends GetxController {
  //controller choice
  int choice = 1;

  void setChoice(int val) {
    choice = val;
    update();
  }

  //controller filter
  int groupValueTotal = 0;
  String cluster = "Adakah 1";
  String wamen = "2020";
  String classs = "2020";

  void setGroupValueTotal(int val) {
    groupValueTotal = val;
    update();
  }

  void setCluster(String val) {
    cluster = val;
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
}
