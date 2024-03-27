import 'package:get/get.dart';

class PieChartTouchController extends GetxController {
  int touchIndex;

  void setTouchIndex(int val) {
    touchIndex = val;
    update();
  }
}
