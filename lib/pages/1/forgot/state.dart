import 'package:get/get.dart';

class ForgotState {
  String email = "";
  // title
  final _title = "Forgot".obs;
  set title(value) => _title.value = value;
  get title => _title.value;
}
