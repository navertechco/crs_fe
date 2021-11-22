import 'package:get/get.dart';
import 'package:naver_crs/common/constants.dart';
import 'package:naver_crs/common/index.dart';
import 'package:sweetalert/sweetalert.dart';
import 'dart:io';

import 'package:pdf/widgets.dart' as pw;
import 'index.dart';

class DGalleryController extends GetxController {
  DGalleryController();

  final state = DGalleryState();
  var session = getContext('session');

  Future<void> pdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Text('Hello World!'),
        ),
      ),
    );

    final file = File('example.pdf');
    // await file.writeAsBytes(await pdf.save());
  }

  void onEnd(ctx, msg) {
    return SweetAlert.show(ctx,
        title: msg,
        subtitle: 'Nos vemos en el siguiente torneo',
        style: SweetAlertStyle.success, onPress: (bool isConfirm) {
      Get.toNamed("/DGallery");
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
