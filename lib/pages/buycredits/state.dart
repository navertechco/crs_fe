import 'package:get/get.dart';

class BuyCreditsState {
  // title
  final _title = "BuyCredits".obs;
  set title(value) => _title.value = value;
  get title => _title.value;
}
