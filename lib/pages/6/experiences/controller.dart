import 'package:get/get.dart';
import '../../index.dart';
import 'widgets/experiencedetail/state.dart'; 

class ExperiencesController extends GetxController {
  ExperiencesController();

  final state = ExperienceDetailState();

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
