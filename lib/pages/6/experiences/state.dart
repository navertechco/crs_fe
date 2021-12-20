import 'package:get/get.dart';

class ExperiencesState {
  // title
  final _title = '''asd'''.obs;
  set title(value) => _title.value = value;
  get title => _title.value;
}
