// ignore_for_file: unnecessary_this

import 'package:get/get.dart';

class TourState extends GetXState {
  TourState() {
    // ignore: prefer_function_declarations_over_variables, unused_local_variable
    toMap = () {
      return {
        "country": country,
        "accomodation_type": accomodation_type,
        "purpose": purpose,
        "passengers": passengers,
        "arrival_date": arrivalDate,
        "departure_date": departureDate
      };
    };
  }
  // ignore: prefer_function_declarations_over_variables
  Function toMap = () {};
  String country = "";
  // ignore: non_constant_identifier_names
  String accomodation_type = "";
  String purpose = "";
  String passengers = "";
  DateTime arrivalDate = DateTime.now();
  DateTime departureDate = DateTime.now();
}
