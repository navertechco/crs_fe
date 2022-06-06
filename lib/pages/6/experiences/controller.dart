import 'package:get/get.dart';
import 'package:naver_crs/pages/5/destination/widgets/index.dart';
import 'package:naver_crs/index.dart';

class ExperiencesController extends GetxController {
  ExperiencesController();

  final state = DestinationDetailState();

  @override
  void onInit() {
    super.onInit();
    filterSuggestedExperiences();
  }

  @override
  void refresh() {
    super.refresh();
    filterSuggestedExperiences();
  }
}
