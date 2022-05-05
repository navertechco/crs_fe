import 'package:get/get.dart';

import 'controller.dart';

class ServicesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServicesController>(() => ServicesController());
  }
}
