// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:get/get.dart';
import 'package:naver_crs/index.dart';

class TourController extends GetxController {
  final state = TourState();
  // ignore: prefer_function_declarations_over_variables
  Function sendTour = () {};

  TourController() {
// ignore: prefer_function_declarations_over_variables
    sendTour = () {
      // Map tour = globalctx.memory["tour"];
      // Map formData = state.toMap();
      // Map mem = {...tour, ...formData};
      // globalctx.memory["tour"] = mem;
      Get.toNamed("/Logistic");
    };
  }
}
