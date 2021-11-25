import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/widgets/index.dart';
import 'widgets/index.dart';

import 'index.dart';

class SignupPage extends GetView<SignupController> {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildSignupFormPage(context),
    );
  }
}

GetBuilder<SignupController> _buildSignupFormPage(
  BuildContext context,
) {
  return GetBuilder<SignupController>(
    id: 'signup_form_page',
    builder: (controller) => ContentLayoutWidget(
        background: "assets/custom/img/register.png",
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(height: Get.height * 0.3),
                  Image.asset("assets/custom/img/pipe.png",
                      width: Get.width * 0.3, height: Get.height * 0.4),
                ],
              ),
            ),
            SignupFormPage(ctrl: controller),
          ],
        ),
        text: "              "),
  );
}
