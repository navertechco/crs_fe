import 'package:get/get.dart';

class SplashState {
  // title
  final _title = "SPLASH".obs;
  set title(value) => _title.value = value;
  get title => _title.value;
}
