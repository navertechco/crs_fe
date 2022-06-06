import 'package:get/get.dart';

class ForgotState extends GetXState {
  String email = '';
  // title
  final _title = "Forgot".obs;
  set title(value) => _title.value = value;
  get title => _title.value;
}
