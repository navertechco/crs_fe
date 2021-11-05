import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../index.dart';

/// hello
class ManualWidget extends GetView<ManualController> {
  const ManualWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Obx(() => Text(controller.state.title,
            style: GoogleFonts.comicNeue(
                textStyle: const TextStyle(height: 1.5, fontSize: 20)))),
      ),
    );
  }
}
