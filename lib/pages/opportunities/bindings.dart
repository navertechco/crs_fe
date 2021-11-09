import 'package:get/get.dart';

import 'controller.dart';

class OpportunitiesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OpportunitiesController>(() => OpportunitiesController());
  }
}
