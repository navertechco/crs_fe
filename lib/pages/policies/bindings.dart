import 'package:get/get.dart';

import 'controller.dart';

class PoliciesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PoliciesController>(() => PoliciesController());
  }
}
