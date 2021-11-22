import 'package:get/get.dart';

import 'controller.dart';

class CustomerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerController>(() => CustomerController());
  }
}
