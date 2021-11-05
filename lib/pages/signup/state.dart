import 'package:get/get.dart';

class SignupState {
  bool isLoading = false;
  String? error = "";
  String username = "";
  String identification = "";
  String surname = "";
  String lastname = "";
  String email = "";
  String phone = "";
  String password = "";

  // title
  final _title = "SIGNUP".obs;
  set title(value) => _title.value = value;
  get title => _title.value;
}
