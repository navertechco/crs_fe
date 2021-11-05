import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/widgets/index.dart';
import 'package:naver_crs/pages/manual/widgets/manual_widget.dart';

import 'index.dart';

class ManualPage extends GetView<ManualController> {
  const ManualPage({Key? key}) : super(key: key);

  Widget _buildView(BuildContext? _context) {
    return const ContentLayoutWidget(child: ManualWidget(), text: "Manual");
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
