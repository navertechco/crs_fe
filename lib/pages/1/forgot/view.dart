import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';
import 'widgets/index.dart';

class ForgotPage extends GetView<ForgotController> {
  const ForgotPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildForgotFormPage(context),
    );
  }
}

GetBuilder<ForgotController> _buildForgotFormPage(
  BuildContext context,
) {
  return GetBuilder<ForgotController>(
    id: 'forgot_form_page',
    builder: (controller) => ContentLayoutWidget(
        background: "assets/images/1x/home.png",
        child: ForgotFormPage(ctrl: controller),
        text: ''),
  );
}
