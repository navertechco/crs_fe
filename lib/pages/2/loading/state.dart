import 'package:get/get.dart';

import '../../index.dart';

class LoadingState {
  // title
  final _title = "AJA".obs;
  set title(value) => _title.value = value;
  get title => _title.value;

  
}
