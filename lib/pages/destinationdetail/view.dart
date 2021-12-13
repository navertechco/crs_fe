import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/widgets/index.dart';

import 'index.dart';
import 'widgets/index.dart';

class DestinationDetailPage extends GetView<DestinationDetailController> {
  const DestinationDetailPage({Key? key}) : super(key: key);

  Widget _buildView(BuildContext? _context) {
    return ContentLayoutWidget(
        background: "assets/custom/img/layout.png",
        child: const DestinationDetailWidget(),
        text: "<   DestinationDetail");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: _buildView(context),
        ));
  }
}
