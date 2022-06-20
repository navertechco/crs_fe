import 'package:flutter/material.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sweetalert/sweetalert.dart';

class SigninController extends GetxController {
  SigninController();

  var state = SigninState();
  var isLoading = false;

  Future<void> onSignin(ctx, String username, String password) async {
    await loadDummyData("countries");
    session["username"] = username;
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
          SweetAlert.show(ctx,
              curve: ElasticInCurve(),
              title: res['message'],
              style: SweetAlertStyle.error, onPress: (bool isConfirm) {
            logOut(session["username"]);
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
