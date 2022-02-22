import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/index.dart';
import 'index.dart';
import '../../index.dart';

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
  return GetBuilder<TourController>(
    id: 'Tour_form_page',
    builder: (controller) => Stack(
      children: [
        ContentLayoutWidget(
            background: "assets/custom/img/tourparameters.png",
            child: TourFormPage(ctrl: controller),
            text: "              "),
      ],
    ),
  );
}
