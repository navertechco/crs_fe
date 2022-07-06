import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';
import 'widgets/index.dart';

class ServicesPage extends GetView<ServicesController> {
  const ServicesPage({Key? key}) : super(key: key);

  Widget _buildView(BuildContext? _context) {
    return ContentLayoutWidget(
        background: "assets/images/1x/layout.png",
        child: ServicesWidget(ctrl: controller),
        text: '');
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
