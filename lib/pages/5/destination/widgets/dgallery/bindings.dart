import 'package:get/get.dart';

import 'controller.dart';

class DGalleryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DGalleryController>(() => DGalleryController());
  }
}
