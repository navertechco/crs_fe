// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import '../index.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:sweetalertv2/sweetalertv2.dart';

class DGalleryController extends GetxController {
  final state = DGalleryState();
  var session = getContext('session');
  var galeryData;

  Future<void> pdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Text('Hello World!'),
        ),
      ),
    );

    // await file.writeAsBytes(await pdf.save());
  }

  void onEnd(ctx, msg) {
    return SweetAlertV2.show(ctx,
        curve: ElasticInCurve(),
        title: msg,
        subtitle: 'Nos vemos en el siguiente torneo',
        style: SweetAlertV2Style.success, onPress: (bool isConfirm) {
      Get.toNamed("/DGallery");
      return false;
    });
  }

  Future<void> onJoinTournament(ctx) async {
    var res = await fetchHandler(kDefaultSchema, kDefaultServer,
        kDefaultServerPort, kDefaultJoinTournmanetPath, 'POST', {
      "data": {"identification": session['identification']}
    });

    if (res['state'] == true) {
      setContext('polls', res['data']);
      Get.toNamed("/Questionary");
    } else {
      onEnd(ctx, res['message']);
    }
  }
}
