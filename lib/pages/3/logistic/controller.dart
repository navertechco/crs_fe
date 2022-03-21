// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:get/get.dart';
import '../../index.dart';
import 'index.dart';

class LogisticController extends GetxController {
  final state = LogisticState();
  // ignore: prefer_function_declarations_over_variables
  Function saveLogistic = () {};

  LogisticController() {
// ignore: prefer_function_declarations_over_variables
    saveLogistic = () {
      Map logistic = globalctx.memory["logistic"];
      Map formData = state.toMap();
      Map mem = {...logistic, ...formData};
      globalctx.memory["logistic"] = mem;
      filterDestinations();

      Get.toNamed("/Customer");
    };
  }
}
