import 'package:get/get.dart';

import 'controller.dart';

class NetRateBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NetRateController>(() => NetRateController());
  }
}
