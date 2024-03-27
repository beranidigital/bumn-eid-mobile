import 'package:get/get_state_manager/get_state_manager.dart';

class AsJamController extends GetxController {
  int kondisiSummary = 0;

  void setKondisiSummary(val) {
    kondisiSummary = val;
    update();
  }
}
