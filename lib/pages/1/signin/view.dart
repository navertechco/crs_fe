import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/widgets/index.dart';
import 'widgets/index.dart';

import 'index.dart';

class SigninPage extends GetView<SigninController> {
  const SigninPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildSigninFormPage(context),
    );
  }
}

GetBuilder<SigninController> _buildSigninFormPage(
  BuildContext context,
) {
  return GetBuilder<SigninController>(
    id: 'signin_form_page',
    builder: (controller) => ContentLayoutWidget(
        background: "assets/custom/img/home.png",
        child: SigninFormPage(ctrl: controller),
        text: "<  Signin"),
  );
}
