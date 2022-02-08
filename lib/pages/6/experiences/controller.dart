import 'package:get/get.dart';
import 'package:naver_crs/pages/5/destination/widgets/index.dart';

import '../../index.dart';
import 'index.dart';

class ExperiencesController extends GetxController {
  ExperiencesController();

  final state = DestinationDetailState();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print("init Experiences");

    filterSuggestedExperiences();
  }

  @override
  void refresh() {
    super.refresh();
    print("update Experiences");
    filterSuggestedExperiences();
  }
}
