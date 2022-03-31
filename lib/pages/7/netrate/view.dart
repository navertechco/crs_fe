import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/index.dart';
import 'index.dart';
import '../../index.dart';

class NetRatePage extends GetView<NetRateController> {
  const NetRatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildNetRateFormPage(context),
      bottomNavigationBar: NavBarWidget(),
    );
  }
}

GetBuilder<NetRateController> _buildNetRateFormPage(
  BuildContext context,
) {
  return GetBuilder<NetRateController>(
    id: 'signin_form_page',
    builder: (controller) => ContentLayoutWidget(
        background: "assets/custom/img/home.png",
        child: NetRateFormPage(ctrl: controller),
        text: "<  NetRate"),
  );
}
