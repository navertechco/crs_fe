import 'package:get/get.dart';
import 'package:naver_crs/common/constants.dart';
import 'package:naver_crs/common/index.dart';
import 'package:sweetalert/sweetalert.dart';

import 'index.dart';

class SurveyController extends GetxController {
  SurveyController();

  final state = SurveyState();
  var session = getContext('session');

  void onEnd(ctx, msg) {
    return SweetAlert.show(ctx,
        title: msg,
        subtitle: 'Nos vemos en el siguiente torneo',
        style: SweetAlertStyle.success, onPress: (bool isConfirm) {
      Get.toNamed("/Survey");
      return false;
    });
  }

  Future<void> onJoinTournament(ctx) async {
    var res = await fetchhandler(kDefaultSchema, kDefaultServer,
        kDefaultServerPort, kDefaultJoinTournmanetPath, 'POST', {
      "data": {"identification": session['identification']}
    });
    print(res);

    if (res['state'] == true) {
      setContext('polls', res['data']);
      Get.toNamed("/Questionary");
    } else {
      onEnd(ctx, res['message']);
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
