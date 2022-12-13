import 'package:get/get.dart';

class DataController extends GetxController {
  RxBool _isFavorite = false.obs;
  bool get isFavorite => _isFavorite.value;

  setIsFavorite(bool isFavorite) {
    _isFavorite.value = isFavorite;
  }
}
