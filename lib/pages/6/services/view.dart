import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../index.dart';
import 'widgets/index.dart';
import 'index.dart';

class ServicesPage extends GetView<ServicesController> {
  const ServicesPage({Key? key}) : super(key: key);

  Widget _buildView(BuildContext? _context) {
    return ContentLayoutWidget(
        background: "assets/custom/img/layout.png",
        child: ServicesWidget(ctrl: controller),
        text: "");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: _buildView(context),
          bottomNavigationBar: NavBarWidget(),
        ));
  }
}
