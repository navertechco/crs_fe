import 'package:get/get.dart';

import 'controller.dart';

class CongratsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CongratsController>(() => CongratsController());
  }
}
