// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:get/get.dart';
import 'package:sweetalert/sweetalert.dart';
import 'index.dart';
import '../../index.dart';

class TourController extends GetxController {
  TourController();

  final state = TourState();
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

  Future<void> onTour(
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
        "state": "Tour"
      }
    });

    if (res['state'] == true) {
      onEnd(ctx, res['data'], true);
    } else {
      onEnd(ctx, res['message'], false);
    }
  }
}
