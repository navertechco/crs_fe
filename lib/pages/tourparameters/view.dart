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
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                  Image.asset("assets/custom/img/pipe.png",
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.4),
                ],
              ),
            ),
            TourParametersFormPage(ctrl: controller),
          ],
        ),
        text: "              "),
  );
}
