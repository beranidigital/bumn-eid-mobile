import 'package:get/get.dart';

class DetailPerusahaanController extends GetxController {
  int choiceMenu = 0;

  void setChoiceMenu(val) {
    choiceMenu = val;
    update(['detailPerusahaan']);
  }

  int choiceSubMenu = 0;

  void setChoiceSubMenu(val) {
    choiceSubMenu = val;
    update(['subDetailPerusahaan']);
  }

  int meninggalKondisi = 0;

  void setMeninggalKondisi(val) {
    meninggalKondisi = val;
    update(['meninggalKondisi']);
  }

  int anggaranKondisi = 0;

  void setAnggaranKondisi(val) {
    anggaranKondisi = val;
    update(['anggaranKondisi']);
  }

  int learningKondisi = 0;

  void setLearningKondisi(val) {
    learningKondisi = val;
    update(['learningKondisi']);
  }

  int inovasiKondisi = 0;

  void setInovasiKondisi(val) {
    inovasiKondisi = val;
    update(['inovasiKondisi']);
  }
}
