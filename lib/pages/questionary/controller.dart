import 'package:get/get.dart';
import 'package:naver_trivia/common/constants.dart';
import 'package:naver_trivia/common/index.dart';
import 'package:sweetalert/sweetalert.dart';

import 'index.dart';

class QuestionaryController extends GetxController {
  QuestionaryController();

  final state = QuestionaryState();

  void onEnd(ctx, msg, success) {
    return SweetAlert.show(ctx,
        title: msg,
        subtitle: success
            ? 'Nos vemos en el siguiente torneo'
            : 'Intenta con otro usuario',
        style: success ? SweetAlertStyle.success : SweetAlertStyle.error,
        onPress: (bool isConfirm) {
      Get.toNamed('/Dashboard');
      return false;
    });
  }

  Future<void> onSendPoll(
    ctx,
    List<dynamic> answers,
  ) async {
    state.identification = getContext('session')["identification"];
    state.answers = answers;
    var time = getContext('time');
    setContext("answers", answers);
    var timeelapsed = time.split(',')[2].split(':')[1] +
        ":" +
        time.split(',')[3].split(':')[1];
    setContext('timeelapsed', timeelapsed);

    var res = await fetchhandler(kDefaultSchema, kDefaultServer,
        kDefaultServerPort, kDefaultSendPollPath, 'POST', {
      "data": {
        "identification": state.identification,
        "time_elapsed": timeelapsed,
        "answers": state.answers
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
