import 'package:get/get.dart';

class SettingsState {
  // title
  final _title = "SETTINGS".obs;
  set title(value) => _title.value = value;
  get title => _title.value;
}
