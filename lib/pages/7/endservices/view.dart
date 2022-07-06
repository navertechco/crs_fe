import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';
import 'widgets/index.dart';

class PrintDocsPage extends GetView<PrintDocsController> {
  const PrintDocsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPrintDocsFormPage(context),
      bottomNavigationBar: NavBarWidget(),
    );
  }
}

GetBuilder<PrintDocsController> _buildPrintDocsFormPage(
  BuildContext context,
) {
  return GetBuilder<PrintDocsController>(
    id: 'signin_form_page',
    builder: (controller) => ContentLayoutWidget(
        background: "assets/images/1x/home.png",
        child: PrintDocsFormPage(ctrl: controller),
        text: "<  PrintDocs"),
  );
}
