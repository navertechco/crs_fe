import 'package:get/get.dart';

import 'controller.dart';

class QuestionaryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuestionaryController>(() => QuestionaryController());
  }
}
