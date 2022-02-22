import 'package:get/get.dart';

class NetRateState extends GetXState {
  // title
  final _title = '''asd'''.obs;
  set title(value) => _title.value = value;
  get title => _title.value;
}
