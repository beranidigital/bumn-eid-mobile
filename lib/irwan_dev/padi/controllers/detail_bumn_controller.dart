import 'package:get/get.dart';

class DetailBumnController extends GetxController {
  int choiceSummary = 0;

  void setChoiceSummary(val) {
    choiceSummary = val;
    update(['choiceSummary']);
  }
}
