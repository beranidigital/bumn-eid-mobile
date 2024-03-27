import 'package:get/get.dart';

class GarudaController extends GetxController {
  int kondisiLayanan = 0;

  void setKondisiLayanan(val) {
    kondisiLayanan = val;
    update();
  }
}
