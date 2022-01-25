// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:get/get.dart';
import 'index.dart';
import '../../index.dart';

class TourController extends GetxController {
  final state = TourState();
  // ignore: prefer_function_declarations_over_variables
  Function saveTour = () {};

  TourController() {

// ignore: prefer_function_declarations_over_variables
    saveTour = () {
      globalctx.memory["tour"].value = state.toMap();
      Get.toNamed("/Customer");
    };
  }
}
