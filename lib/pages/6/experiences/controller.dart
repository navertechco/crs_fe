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

    filterExperiences();
  }

  @override
  void onDestroy() {
    print("update Experiences");
    filterExperiences();
  }

  @override
  void onUpdate() {
    print("update Experiences");
    filterExperiences();
  }
}
