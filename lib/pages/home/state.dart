import 'package:get/get.dart';

class HomeState {
  // title
  final _title = "AJA".obs;
  set title(value) => this._title.value = value;
  get title => this._title.value;
}
