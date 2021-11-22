import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../index.dart';

/// hello
class CongratsWidget extends GetView<CongratsController> {
  const CongratsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() => Text(controller.state.title,
                style: GoogleFonts.comicNeue(
                    textStyle: const TextStyle(height: 1.5, fontSize: 20)))),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text('Acepto'),
                  onPressed: () => Get.toNamed('/Dashboard'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
