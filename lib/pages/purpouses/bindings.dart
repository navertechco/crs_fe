import 'package:get/get.dart';

import 'controller.dart';

class PurpousesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PurpousesController>(() => PurpousesController());
  }
}
