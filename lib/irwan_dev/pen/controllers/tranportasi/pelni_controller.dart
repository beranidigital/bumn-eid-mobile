import 'package:get/get.dart';

class PelniController extends GetxController {
  int kondisiSummary = 0;

  void setKondisiSummary(val) {
    kondisiSummary = val;
    update();
  }
}
