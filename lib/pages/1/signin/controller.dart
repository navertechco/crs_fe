import 'package:get/get.dart';

import '../../index.dart';
import 'index.dart';

class SigninController extends GetxController {
  SigninController();

  var state = SigninState();
  var isLoading = false;

  Future<void> onSignin(String username, String password) async {
    // Get.toNamed('/Loading');

    state.error = null;
    state.username = username;
    state.password = password;

    try {
      if (!isLoading) {
        isLoading = !isLoading;
        var res = await fetchhandler(kDefaultSchema, kDefaultServer,
            kDefaultServerPort, kDefaultConnectPath, 'POST', {
          "state": "signin",
          "data": {"username": state.username, "password": state.password}
        });

        if (res['state'] == true) {
          setContext("catalogs", res['data']["catalogs"]);
          isLoading = !isLoading;
          Get.toNamed('/Loading');
        } else {
          isLoading = !isLoading;
          print(res);
        }
      }
    } catch (e) {
      isLoading = !isLoading;
      print(e);
    }
  }
}
