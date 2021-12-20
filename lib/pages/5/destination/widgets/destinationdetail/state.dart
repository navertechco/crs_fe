import 'package:get/get.dart';

class DestinationDetailState {
  // title
  final _title = '''asd'''.obs;

  set title(value) => _title.value = value;
  get title => _title.value;

  Rx<List> destinationlist = Rx([]);
}
