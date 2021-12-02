import 'package:get/get.dart';
import 'package:naver_crs/common/constants.dart';
import 'package:naver_crs/common/index.dart';
import 'package:sweetalert/sweetalert.dart';

import 'index.dart';

class ForgotController extends GetxController {
  ForgotController();

  final state = ForgotState();
  void onEnd(ctx, msg, success) {
    return SweetAlert.show(ctx,
        title: msg,
        subtitle: success
            ? 'Se envió un formulario de recuperación a tu correo'
            : 'Intenta con otro email',
        style: success ? SweetAlertStyle.success : SweetAlertStyle.error,
        onPress: (bool isConfirm) {
      Get.toNamed("/Home");
      return false;
    });
  }

  Future<void> onForgot(ctx, String email) async {
    state.email = email;

    var res = await fetchhandler(kDefaultSchema, kDefaultServer,
        kDefaultServerPort, kDefaultConnectPath, 'POST', {
      "data": {"email": state.email, "state": "forgot"}
    });
    print(res);

    if (res['state'] == true) {
      onEnd(ctx, res['data'], true);
    } else {
      onEnd(ctx, res['message'], false);
    }
  }
}
