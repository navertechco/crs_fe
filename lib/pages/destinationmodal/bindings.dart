import 'package:get/get.dart';

import 'controller.dart';

class DestinationModalBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DestinationModalController>(() => DestinationModalController());
  }
}
