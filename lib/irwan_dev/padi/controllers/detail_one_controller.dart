import 'package:get/get.dart';

class DetailOneController extends GetxController {
  int choiceView = 0;

  void setChoiceView(val) {
    choiceView = val;
    update(['detailOneChoice']);
  }
}
