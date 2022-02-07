import 'package:get/get.dart';

class LoadingState extends GetXState {
  // title
  final _title = "AJA".obs;
  set title(value) => _title.value = value;
  get title => _title.value;
}
