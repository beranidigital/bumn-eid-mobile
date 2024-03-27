import 'package:get/get.dart';

class SummaryDashboardController extends GetxController {
  int meninggalKondisi = 0;

  void setMeninggalKondisi(val) {
    meninggalKondisi = val;
    update(['unitMeninggal']);
  }

  int anggaranKondisi = 0;

  void setAnggaranKondisi(val) {
    anggaranKondisi = val;
    update(['unitAnggaran']);
  }

  int anggaranLearning = 0;

  void setAnggaranLearning(val) {
    anggaranLearning = val;
    update(['unitLearning']);
  }

  int anggaranInovasi = 0;

  void setAnggaranInovasi(val) {
    anggaranInovasi = val;
    update(['unitInovasi']);
  }
}
