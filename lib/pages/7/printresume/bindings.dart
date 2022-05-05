import 'package:get/get.dart';

import 'controller.dart';

class PrintResumeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrintResumeController>(() => PrintResumeController());
  }
}
