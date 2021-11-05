import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_trivia/common/constants.dart';
import 'package:naver_trivia/common/index.dart';

import '../index.dart';
import 'index.dart';

class SigninController extends GetxController {
  SigninController();

  var state = SigninState();

  Future<void> onSignin(String username, String password) async {
    state.isLoading = true;
    state.error = null;
    state.username = username;
    state.password = password;

    var res = await fetchhandler(kDefaultSchema, kDefaultServer,
        kDefaultServerPort, kDefaultConnectPath, 'POST', {
      "data": {
        "username": state.username,
        "password": state.password,
        "state": "signin"
      }
    });
    print(res);

    if (res['state'] == true) {
      setContext('session', res['data']);
      Get.toNamed('/Dashboard');
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
