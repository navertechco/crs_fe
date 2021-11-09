import 'package:get/get.dart';

import 'controller.dart';

class DestinationsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DestinationsController>(() => DestinationsController());
  }
}
