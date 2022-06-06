import 'package:get/get.dart';

class PrintResumeState extends GetXState {
  // title
  bool isLoading = false;
  String? error = '';
  String username = '';
  String password = '';

  final _title = "SIGNIN".obs;
  set title(value) => _title.value = value;
  get title => _title.value;
}
