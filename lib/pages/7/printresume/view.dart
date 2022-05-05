import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/index.dart';
import 'index.dart';
import '../../index.dart';

class PrintResumePage extends GetView<PrintResumeController> {
  const PrintResumePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPrintResumeFormPage(context),
      bottomNavigationBar: NavBarWidget(),
    );
  }
}

GetBuilder<PrintResumeController> _buildPrintResumeFormPage(
  BuildContext context,
) {
  return GetBuilder<PrintResumeController>(
    id: 'signin_form_page',
    builder: (controller) => ContentLayoutWidget(
        background: "assets/custom/img/home.png",
        child: PrintResumeFormPage(ctrl: controller),
        text: "<  PrintResume"),
  );
}
