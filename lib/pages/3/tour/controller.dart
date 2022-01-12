// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:get/get.dart'; 
import 'index.dart';
import '../../index.dart';

class TourController extends GetxController {
  final state = TourState();
  Function saveTour = () {};

  TourController() {
// ignore: prefer_function_declarations_over_variables
    saveTour = () {
      var tour = getContext("tour");
      if (tour != null) {
        tour["tour"] = state.toMap();
      }
      Get.toNamed("/Customer");
    };
  }
}
