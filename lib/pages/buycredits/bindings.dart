import 'package:get/get.dart';

import 'controller.dart';

class BuyCreditsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BuyCreditsController>(() => BuyCreditsController());
  }
}
