import 'package:get/get.dart';

import 'controller.dart';

class SurveyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SurveyController>(() => SurveyController());
  }
}
