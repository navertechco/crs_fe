// ignore_for_file: unnecessary_this

import 'package:get/get.dart';

class CustomerState extends GetXState {
  CustomerState() {
    // ignore: prefer_function_declarations_over_variables, unused_local_variable
    toMap = () {
      return {
        "contact_name": contactName,
        "customer_type": customerType,
        "country": country,
        "email": email,
        "travel_code": travelCode,
        "lead_passenger": leadPassenger,
        "address_line": addressLine,
        "city": city,
        "dni": dni,
        "tax_id": taxId,
        "names": names,
        "last_names": lastNames,
        "birth_date": birthDate,
      };
    };
  }
  // ignore: prefer_function_declarations_over_variables
  Function toMap = () {};
  String contactName = '';
  String city = '';
  String state = '';
  String addressLine = '';
  String leadPassenger = '';
  String travelCode = '';
  String email = '';
  String country = '';
  String customerType = '';
  // ignore: non_constant_identifier_names
  String dni = '';
  String taxId = '';
  String names = '';
  String lastNames = '';
  String birthDate = '';
}
