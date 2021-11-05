import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/widgets/index.dart';
import 'widgets/index.dart';

import 'index.dart';

class SigninPage extends GetView<SigninController> {
  const SigninPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: _buildSigninFormPage(context),
        ));
  }
}

GetBuilder<SigninController> _buildSigninFormPage(
  BuildContext context,
) {
  return GetBuilder<SigninController>(
    id: 'signin_form_page',
    builder: (controller) => ContentLayoutWidget(
        child: SigninFormPage(ctrl: controller), text: "Ingresar"),
  );
}
