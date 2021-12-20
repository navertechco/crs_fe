import 'package:get/get.dart';

import 'controller.dart';

class DestinationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DestinationController>(() => DestinationController());
  }
}
