import 'package:get/get.dart';

import 'controller.dart';

class LeisureTimeDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeisureTimeDetailController>(
        () => LeisureTimeDetailController());
  }
}
