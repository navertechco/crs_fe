import 'package:get/get.dart';

class TourParametersState {
  bool isLoading = false;
  String? error = "";
  String username = "";
  String identification = "";
  String name = "";
  String firstname = "";
  String lastname = "";
  String email = "";
  String phone = "";
  String password = "";
  String confirmation = "";

  // title
  final _title = "TourParameters".obs;
  set title(value) => _title.value = value;
  get title => _title.value;
}
