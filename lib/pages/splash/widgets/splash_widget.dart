import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../index.dart';

/// hello
class SplashWidget extends GetView<SplashController> {
  const SplashWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(() => Text(controller.state.title)),
    );
  }
}
