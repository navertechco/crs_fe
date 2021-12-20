import 'package:get/get.dart';

import 'controller.dart';

class DestinationDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DestinationDetailController>(
        () => DestinationDetailController());
  }
}
