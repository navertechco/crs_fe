import 'package:get/get.dart';

class RankingState {
  // title
  final _title = "Ranking".obs;
  set title(value) => _title.value = value;
  get title => _title.value;
}
