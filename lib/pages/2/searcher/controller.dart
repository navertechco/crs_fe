import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sweetalert/sweetalert.dart';

import '../../index.dart';
import 'index.dart';

class SearcherController extends GetxController {
  SearcherController();

  final state = SearcherState();

  Future<void> getTour(ctx, {int tourId = 0}) async {
    if (tourId > 0) {
      var res = await fetchhandler(kDefaultSchema, kDefaultServer,
          kDefaultServerPort, kDefaultFindTour, 'POST', {
        "data": {"tour_id": "$tourId"}
      });
      // ignore: avoid_print
      log(res);
      if (res['state'] == true) {
        var data = res['data'];
        if (data.length > 0) {
          globalctx.memory.value = {...globalctx.memory.value, ...data};
          setContext("tour", data);
          setContext("customer", data["customer"]);
          setContext("readonly", true);
          Get.toNamed("/Tour");
        }
      } else {
        SweetAlert.show(ctx,
            curve: ElasticInCurve(),
            title: res['message'],
            style: SweetAlertStyle.error, onPress: (bool isConfirm) {
          Get.close(1);
          return false;
        });
      }
    } else {
      Get.toNamed("/Tour");
    }
  }
}
