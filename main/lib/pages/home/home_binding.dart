import 'package:get/get.dart';

import 'home_api.dart';
import 'home_controller.dart';
import 'home_repository.dart';

class HomeBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<HomeController>(() => HomeController(
     HomeRepository(HomeApi())));
  }
}