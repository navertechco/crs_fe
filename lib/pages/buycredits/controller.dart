import 'package:get/get.dart';
import 'package:naver_trivia/common/constants.dart';
import 'package:naver_trivia/common/index.dart';
import 'package:sweetalert/sweetalert.dart';

import 'index.dart';

class BuyCreditsController extends GetxController {
  BuyCreditsController();

  final state = BuyCreditsState();

  void onEnd(ctx, msg, success) {
    return SweetAlert.show(ctx,
        title: msg,
        subtitle: success ? 'En breve le confirmamos el pago' : 'Error en la transaccion',
        style: success ? SweetAlertStyle.success : SweetAlertStyle.error,
        onPress: (bool isConfirm) {
      Get.toNamed("/Home");
      return false;
    });
  }

  Future<void> onBuyCredits(ctx) async {
    Map<dynamic, dynamic> state = getContext('global');
    Map? session = getContext('session');
    var res = await fetchhandler(kDefaultSchema, kDefaultServer,
        kDefaultServerPort, kDefaultBuyCreditsPath, 'POST', {
      "data": {
        "email":
            session != null ? session['email'].toString() : "josecuevas70hotmail.com",
        "identification":
            session != null ? session['identification'].toString() : "8888",
        "description": state['reference'].toString(),
        "credits": state['n'].value,
        "payment_type": state['payment'],
        "institution": state['institution']
      }
    });
    print(res);

    if (res['state'] == true) {
      onEnd(ctx, res['data'], true);
    } else {
      onEnd(ctx, res['message'], false);
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
