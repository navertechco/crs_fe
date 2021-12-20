import 'package:get/get.dart';

import 'controller.dart';

class TourBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TourController>(() => TourController());
  }
}
