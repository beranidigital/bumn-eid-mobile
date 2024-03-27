import 'package:get/get.dart';

class AsdpFerryController extends GetxController {
  int kondisiPergerakan = 0;

  void setKondisiPergerakan(val) {
    kondisiPergerakan = val;
    update();
  }
}
