import 'package:get/get.dart';

import 'controller.dart';

class ServiceDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServiceDetailController>(() => ServiceDetailController());
  }
}
