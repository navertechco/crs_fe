import 'package:get/get.dart';

import 'controller.dart';

class ResumeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResumeController>(() => ResumeController());
  }
}
