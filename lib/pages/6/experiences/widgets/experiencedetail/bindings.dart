import 'package:get/get.dart';

import 'controller.dart';

class ExperienceDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExperienceDetailController>(() => ExperienceDetailController());
  }
}
