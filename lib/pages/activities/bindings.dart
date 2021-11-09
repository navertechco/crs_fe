import 'package:get/get.dart';

import 'controller.dart';

class ActivitiesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActivitiesController>(() => ActivitiesController());
  }
}
