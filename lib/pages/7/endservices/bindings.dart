import 'package:get/get.dart';

import 'controller.dart';

class EndServicesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EndServicesController>(() => EndServicesController());
  }
}
