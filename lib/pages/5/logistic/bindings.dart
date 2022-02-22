import 'package:get/get.dart';

import 'controller.dart';

class LogisticBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LogisticController>(() => LogisticController());
  }
}
