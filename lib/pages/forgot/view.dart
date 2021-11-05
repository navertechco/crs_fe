import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_trivia/common/widgets/index.dart';
import 'widgets/index.dart';

import 'index.dart';

class ForgotPage extends GetView<ForgotController> {
  const ForgotPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child:Scaffold(
      body: _buildForgotFormPage(context),
    ));
  }
}

GetBuilder<ForgotController> _buildForgotFormPage(
  BuildContext context,
) {
  return GetBuilder<ForgotController>(
    id: 'forgot_form_page',
    builder: (controller) => ContentLayoutWidget(
        child: ForgotFormPage(ctrl: controller), text: "Recuperar"),
  );
}
