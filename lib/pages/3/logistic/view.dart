import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/index.dart';
import 'package:naver_crs/index.dart';

class LogisticPage extends GetView<LogisticController> {
  const LogisticPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: _buildLogisticFormPage(context),
        bottomNavigationBar: NavBarWidget(),
      ),
    );
  }
}

GetBuilder<LogisticController> _buildLogisticFormPage(
  BuildContext context,
) {
  return GetBuilder<LogisticController>(
    id: 'Logistic_form_page',
    builder: (controller) => Stack(
      children: [
        ContentLayoutWidget(
            background: "assets/images/1x/tourparameters.png",
            child: LogisticFormPage(ctrl: controller),
            text: "              "),
      ],
    ),
  );
}
