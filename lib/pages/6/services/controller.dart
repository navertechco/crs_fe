import 'package:get/get.dart';
import 'package:naver_crs/pages/5/destination/widgets/index.dart';

import '../../../index.dart';

class ServicesController extends GetxController {
  ServicesController();

  final state = DestinationDetailState();

  @override
  void onInit() {
    super.onInit();
    filterSuggestedServices();
  }

  @override
  void refresh() {
    super.refresh();
    filterSuggestedServices();
  }
}
