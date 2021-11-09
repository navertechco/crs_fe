import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:naver_crs/common/index.dart';

class SurveyState {
  final title = getContext('session')['username'].toString().obs;
}
