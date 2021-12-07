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
    builder: (controller) => ContentLayoutWidget(
        background: "assets/custom/img/tourparameters.png",
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: MediaQuery.of(context).size.width * 0.115,
              child: TourParametersFormPage(ctrl: controller),
            ),
          ],
        ),
        text: "              "),
  );
}
