import 'package:get/get_state_manager/get_state_manager.dart';

class SemenIndonesiaController extends GetxController {
  int kondisiSummary = 0;

  int setKondisiSummary(int val) {
    kondisiSummary = val;
    update();
  }
}
