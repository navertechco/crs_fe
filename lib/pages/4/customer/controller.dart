// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:get/get.dart';
import 'package:naver_crs/index.dart';

class CustomerController extends GetxController {
  final state = CustomerState();
  // ignore: prefer_function_declarations_over_variables
  Function saveCustomer = () {};

  CustomerController() {
// ignore: prefer_function_declarations_over_variables
    saveCustomer = () {
      Map mem = {...globalctx.memory["customer"], ...state.toMap()};
      globalctx.memory["customer"] = mem;
      // filterDestinations();
      // resetAllDestinations();
      goto("Destination");
    };
  }
}
