import 'package:get/get.dart';

import 'controller.dart';

class RankingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RankingController>(() => RankingController());
  }
}
