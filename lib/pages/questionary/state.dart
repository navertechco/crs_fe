import 'package:get/get.dart';

class QuestionaryState {
  // title
  String identification = "";
  String tournamentid = "";
  List<dynamic> answers = [];
  final _title = "Cuestionario".obs;
  set title(value) => _title.value = value;
  get title => _title.value;
}
