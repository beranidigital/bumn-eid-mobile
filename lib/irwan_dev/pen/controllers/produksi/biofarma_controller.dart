import 'package:get/get.dart';

class BioFarmaController extends GetxController {
  int kondisiSummary = 0;

  void setKondisiSummary(val) {
    kondisiSummary = val;
    update();
  }
}
