import 'package:get/get.dart';

import 'controller.dart';

class TourParametersBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TourParametersController>(() => TourParametersController());
  }
}
