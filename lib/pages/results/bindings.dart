import 'package:get/get.dart';

import 'controller.dart';

class ResultsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResultsController>(() => ResultsController());
  }
}
