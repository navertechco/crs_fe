import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/index.dart';
import 'index.dart';
import '../../index.dart';

class EndServicesPage extends GetView<EndServicesController> {
  const EndServicesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildEndServicesFormPage(context),
      bottomNavigationBar: NavBarWidget(),
    );
  }
}

GetBuilder<EndServicesController> _buildEndServicesFormPage(
  BuildContext context,
) {
  return GetBuilder<EndServicesController>(
    id: 'signin_form_page',
    builder: (controller) => ContentLayoutWidget(
        background: "assets/custom/img/home.png",
        child: EndServicesFormPage(ctrl: controller),
        text: "<  EndServices"),
  );
}
