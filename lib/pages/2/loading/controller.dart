import 'package:get/get.dart';

import '../../index.dart';
import 'index.dart';

class LoadingController extends GetxController {
  LoadingController();

  final state = LoadingState();

  Future<void> getTour({int tourId = 0}) async {
    var res = await fetchhandler(kDefaultSchema, kDefaultServer,
        kDefaultServerPort, kDefaultQueryPath, 'POST', {
      "data": {
        "table": {"name": "Tour", "id": "$tourId"}
      }
    });
    // ignore: avoid_print
    // print(res);
    if (res['state'] == true) {
      var data = res['data'];
      if (data.length > 0) {
        setContext("tour", data);
        setContext("readonly", true);
      }
    }
    Get.toNamed("/Tour");
  }
}
