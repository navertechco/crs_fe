import 'package:get/get.dart';

class TournamentResultState {
  // title
  final _title = "TournamentResult".obs;
  set title(value) => _title.value = value;
  get title => _title.value;
}
