import 'package:get/get.dart';

import '../../index.dart';
import 'index.dart';

class SigninController extends GetxController {
  SigninController();

  var state = SigninState();

  Future<void> onSignin(String username, String password) async {
    // Get.toNamed('/Loading');
    state.isLoading = true;
    state.error = null;
    state.username = username;
    state.password = password;

    try {
      var res = await fetchhandler(kDefaultSchema, kDefaultServer,
          kDefaultServerPort, kDefaultConnectPath, 'POST', {
        "state": "signin",
        "data": {"username": state.username, "password": state.password}
      });

      if (res['state'] == true) {
        setContext("catalogs", res['data']);
        Get.toNamed('/Loading');
      } else {
        print(res);
      }
    } catch (e) {
      print(e);
    }
  }
}
