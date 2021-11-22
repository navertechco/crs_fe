import 'package:get/get.dart';

import 'controller.dart';

class ArrivalBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ArrivalController>(() => ArrivalController());
  }
}
