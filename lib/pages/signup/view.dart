import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_trivia/common/widgets/index.dart';
import 'widgets/index.dart';

import 'index.dart';

class SignupPage extends GetView<SignupController> {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child:Scaffold(
      body: _buildSignupFormPage(context),
    ));
  }
}

GetBuilder<SignupController> _buildSignupFormPage(
  BuildContext context,
) {
  return GetBuilder<SignupController>(
    id: 'signup_form_page',
    builder: (controller) => ContentLayoutWidget(
        child: SignupFormPage(ctrl: controller), text: "Registrarse"),
  );
}
