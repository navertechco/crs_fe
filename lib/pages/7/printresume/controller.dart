import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sweetalertv2/sweetalertv2.dart';

class PrintResumeController extends GetxController {
  PrintResumeController();

  var state = PrintResumeState();
  var isLoading = false;

  Future<void> onPrintResume(ctx, String username, String password) async {
    state.error = null;
    state.username = username;
    state.password = password;

    try {
      if (!isLoading) {
        isLoading = !isLoading;
        var res = await fetchHandler(kDefaultSchema, kDefaultServer,
            kDefaultServerPort, kDefaultConnectPath, 'POST', {
          "state": "signin",
          "data": {"username": state.username, "password": state.password}
        });

        if (res['state'] == true) {
          isLoading = !isLoading;
          Get.toNamed('/Loading');
        } else {
          isLoading = !isLoading;
          SweetAlertV2.show(ctx,
              curve: ElasticInCurve(),
              title: res['message'],
              style: SweetAlertV2Style.error, onPress: (bool isConfirm) {
            Get.close(1);
            return false;
          });
          log(res);
        }
      }
    } catch (e) {
      isLoading = !isLoading;
      log(e);
    }
  }
}
