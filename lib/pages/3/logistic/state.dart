// ignore_for_file: unnecessary_this

import 'package:get/get.dart';

class LogisticState extends GetXState {
  LogisticState() {
    // ignore: prefer_function_declarations_over_variables, unused_local_variable
    toMap = () {
      return {
        "departure_port": departure_port,
        "arrival_port": arrival_port,
        "arrival_date": arrivalDate,
        "departure_date": departureDate
      };
    };
  }
  // ignore: prefer_function_declarations_over_variables
  Function toMap = () {};
  // ignore: non_constant_identifier_names
  String arrival_port = "";
  // ignore: non_constant_identifier_names
  String departure_port = "";
  String arrivalDate = DateTime.now().toString();
  String departureDate = DateTime.now().toString();
}
