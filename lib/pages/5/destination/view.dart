import 'package:flutter/material.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';

import 'package:naver_crs/index.dart';
import 'package:naver_crs/index.dart';
import 'widgets/index.dart';

class DestinationPage extends GetView<DestinationController> {
  const DestinationPage({Key? key}) : super(key: key);

  Widget _buildView(BuildContext? _context) {
    return ContentLayoutWidget(
        background: "assets/custom/img/dest2.png",
        child: const DestinationWidget(),
        text: "<   Destination");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: _buildView(context),
        bottomNavigationBar: NavBarWidget(),
      ),
    );
  }
}
