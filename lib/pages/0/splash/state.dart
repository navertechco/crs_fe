import 'package:get/get.dart';

class SplashState extends GetXState {
  // title
  final _title = "SPLASH".obs;
  set title(value) => _title.value = value;
  get title => _title.value;
}
