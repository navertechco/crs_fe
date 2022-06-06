// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:naver_crs/index.dart';
import 'package:naver_crs/index.dart';

class ForgotController extends GetxController {
  ForgotController();

  final state = ForgotState();
  void getConfirmation(ctx, msg, success) {
    return SweetAlert.show(ctx,
        curve: ElasticInCurve(),
        title: msg,
        subtitle: success
            ? 'Se envió un formulario de recuperación a tu correo'
            : 'Intenta con otro email',
        style: success ? SweetAlertStyle.success : SweetAlertStyle.error,
        onPress: (bool isConfirm) {
      Get.toNamed("/Signin");
      return false;
    });
  }

  Future<void> onForgot(ctx, String email) async {
    state.email = email;

    var res = await fetchhandler(kDefaultSchema, kDefaultServer,
        kDefaultServerPort, kDefaultConnectPath, 'POST', {
      "state": "forgot",
      "data": {"email": state.email}
    });

    if (res['state']) {
      showCustomDialog(
        ctx,
        Text("A confirmation email was sent !!!!",
            style: KTextSytle(
                    context: ctx,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54)
                .getStyle()),
        "Close",
        backgroundColor: Colors.grey,
        buttonColor: Colors.black,
      );
    } else {
      showCustomDialog(
        ctx,
        Text("The system had a technical problem, try again later",
            style: KTextSytle(
                    context: ctx,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54)
                .getStyle()),
        "Close",
        backgroundColor: Colors.grey,
        buttonColor: Colors.black,
      );
    }
  }
}
