import 'package:get/get.dart';

import 'controller.dart';

class TermsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TermsController>(() => TermsController());
  }
}
