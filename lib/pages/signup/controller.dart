import 'package:get/get.dart';
import 'package:naver_crs/common/constants.dart';
import 'package:naver_crs/common/index.dart';
import 'package:sweetalert/sweetalert.dart';

import 'index.dart';

class SignupController extends GetxController {
  SignupController();

  final state = SignupState();
  void onEnd(ctx, msg, success) {
    return SweetAlert.show(ctx,
        title: msg,
        subtitle: success
            ? 'Nos vemos en el siguiente torneo'
            : 'Intenta con otro usuario',
        style: success ? SweetAlertStyle.success : SweetAlertStyle.error,
        onPress: (bool isConfirm) {
      Get.toNamed("/Home");
      return false;
    });
  }

  Future<void> onSignup(
      ctx,
      String identification,
      String username,
      String firstname,
      String lastname,
      String email,
      String phone,
      String password) async {
    state.isLoading = true;
    state.error = null;
    state.identification = identification;
    state.username = username;
    state.firstname = firstname;
    state.lastname = lastname;
    state.email = email;
    state.phone = phone;
    state.password = password;

    var res = await fetchhandler(kDefaultSchema, kDefaultServer,
        kDefaultServerPort, kDefaultConnectPath, 'POST', {
      "data": {
        "identification": state.identification,
        "username": state.username,
        "firstname": state.firstname,
        "lastname": state.lastname,
        "email": state.email,
        "phone": state.phone,
        "password": state.password,
        "state": "signup"
      }
    });
    print(res);

    if (res['state'] == true) {
      onEnd(ctx, res['data'], true);
    } else {
      onEnd(ctx, res['message'], false);
    }
  }
}
