import 'package:get/get.dart';

import 'controller.dart';

class ManualBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManualController>(() => ManualController());
  }
}
