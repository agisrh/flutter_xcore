import 'package:flutter_xcore/export_helper.dart';

class BaseController extends GetxController {
  var loadingStatus = false.obs;

  bool canRequest() {
    if (!loadingStatus.value) {
      loadingStatus.value = true;
      update();
      return loadingStatus.value;
    }
    return false;
  }

  finishRequest() {
    loadingStatus.value = false;
    update();
  }
}
