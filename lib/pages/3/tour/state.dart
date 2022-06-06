// ignore_for_file: unnecessary_this

import 'package:get/get.dart';

class TourState extends GetXState {
  TourState() {
    // ignore: prefer_function_declarations_over_variables, unused_local_variable
    toMap = () {
      return {
        "country": country,
        "accomodation_type": accomodation_type,
        "passengers": passengers,
      };
    };
  }
  // ignore: prefer_function_declarations_over_variables
  Function toMap = () {};
  String country = '';
  // ignore: non_constant_identifier_names
  String accomodation_type = '';
  int passengers = 0;
}
