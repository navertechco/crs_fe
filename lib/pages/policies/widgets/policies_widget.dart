import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:naver_crs/common/index.dart';
import '../index.dart';

/// hello
class PoliciesWidget extends GetView<PoliciesController> {
  const PoliciesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Obx(() => Text(controller.state.title,
                  style: GoogleFonts.comicNeue(
                      textStyle: const TextStyle(height: 1.5, fontSize: 20)))),
            ),
            Signature(
              color: Colors.black, // Color of the drawing path
              strokeWidth: 5.0, // with
              backgroundPainter:
                  null, // Additional custom painter to draw stuff like watermark
              onSign: null, // Callback called on user pan drawing
              key:
                  null, // key that allow you to provide a GlobalKey that'll let you retrieve the image once user has signed
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.7),
                  SizedBox(
                    child: RoundedFormButton(
                      label: "Accept",
                      onTap: () {
                        Get.toNamed("/Home");
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
