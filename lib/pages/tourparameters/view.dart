import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/widgets/index.dart';
import 'widgets/index.dart';

import 'index.dart';

class TourParametersPage extends GetView<TourParametersController> {
  const TourParametersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildTourParametersFormPage(context),
    );
  }
}

GetBuilder<TourParametersController> _buildTourParametersFormPage(
  BuildContext context,
) {
  return GetBuilder<TourParametersController>(
    id: 'TourParameters_form_page',
    builder: (controller) => SafeArea(
      child: Scaffold(
        body: SafeArea(
          child: ContentLayoutWidget(
              background: "assets/custom/img/tourparameters.png",
              child: TourParametersFormPage(ctrl: controller),
              text: "              "),
        ),
      ),
    ),
  );
}
