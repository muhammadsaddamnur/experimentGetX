import 'dart:math';

import 'package:get/get.dart';

class DetailController extends GetxController {
  RxString coba = ''.obs;
  RxString cobaXXX = ''.obs;

  @override
  void onInit() {
    var rng = Random();
    coba.value = '';
    coba.value = '';
    super.onInit();
  }

  void setCoba({value}) => coba.value = value;
  void setCobaXXX({value}) => cobaXXX.value = value;
}
