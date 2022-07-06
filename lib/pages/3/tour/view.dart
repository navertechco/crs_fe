import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';
import 'widgets/index.dart';

class TourPage extends GetView<TourController> {
  const TourPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: _buildTourFormPage(context),
        bottomNavigationBar: NavBarWidget(),
      ),
    );
  }
}

GetBuilder<TourController> _buildTourFormPage(
  BuildContext context,
) {
  try {
    if (isFirstLaunch) {
      showTutorial(context);
    }
  } catch (e) {
    log(e);
  }

  return GetBuilder<TourController>(
    id: 'Tour_form_page',
    builder: (controller) => Stack(
      children: [
        ContentLayoutWidget(
            background: "assets/images/1x/tourparameters.png",
            child: TourFormPage(ctrl: controller),
            text: "              "),
      ],
    ),
  );
}
