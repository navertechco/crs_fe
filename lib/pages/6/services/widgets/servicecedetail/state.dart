import 'package:get/get.dart';

class ServiceDetailState extends GetXState {
  // title
  final _title = '''asd'''.obs;

  set title(value) => _title.value = value;
  get title => _title.value;

  Rx<List> servicelist = Rx([]);
}
