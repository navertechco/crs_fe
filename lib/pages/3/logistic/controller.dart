// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:get/get.dart';
import 'package:naver_crs/index.dart';

class LogisticController extends GetxController {
  final state = LogisticState();
  // ignore: prefer_function_declarations_over_variables
  Function saveLogistic = () {};

  LogisticController() {
// ignore: prefer_function_declarations_over_variables
    saveLogistic = () {
      // Map logistic = globalctx.memory["logistic"];
      // Map formData = state.toMap();
      // Map mem = {...logistic, ...formData};
      // globalctx.memory["logistic"] = mem;
      arrivalPort.value =
          getFormValue(globalctx.memory, "logistic", "arrival_port", "0");
      departurePort.value =
          getFormValue(globalctx.memory, "logistic", "departure_port", "0");
      filterDestinations();
      gotoPage("Customer");
    };
  }
}
