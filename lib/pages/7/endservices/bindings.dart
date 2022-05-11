import 'package:get/get.dart';

import 'controller.dart';

class PrintDocsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrintDocsController>(() => PrintDocsController());
  }
}
