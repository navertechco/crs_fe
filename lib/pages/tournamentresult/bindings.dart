import 'package:get/get.dart';

import 'controller.dart';

class TournamentResultBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TournamentResultController>(() => TournamentResultController());
  }
}
