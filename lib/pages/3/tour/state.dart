// ignore_for_file: unnecessary_this

class TourState {
  TourState() {
    // ignore: prefer_function_declarations_over_variables, unused_local_variable
    toMap = () {
      return {
        "country": country,
        "accomodation_type": accomodation_type,
        "purpose": purpose,
        "passengers": passengers
      };
    };
  }
  Function toMap = () {};
  String country = "";
  // ignore: non_constant_identifier_names
  String accomodation_type = "";
  String purpose = "";
  String passengers = "";
}
