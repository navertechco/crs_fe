import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/widgets/index.dart';
import 'widgets/index.dart';

import 'index.dart';

class QuestionaryPage extends GetView<QuestionaryController> {
  const QuestionaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: _buildQuestionaryFormPage(context),
        ));
  }
}

GetBuilder<QuestionaryController> _buildQuestionaryFormPage(
  BuildContext context,
) {
  return GetBuilder<QuestionaryController>(
    id: 'signup_form_page',
    builder: (controller) => ContentLayoutWidget(
        child: QuestionaryWidget(ctrl: controller), text: "Registrarse"),
  );
}
