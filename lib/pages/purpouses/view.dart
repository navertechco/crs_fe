import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/widgets/index.dart';
import 'widgets/index.dart';

import 'index.dart';

class PurpousesPage extends GetView<PurpousesController> {
  const PurpousesPage({Key? key}) : super(key: key);

  Widget _buildView(BuildContext? _context) {
    return ContentLayoutWidget(
        child: PurpousesWidget(
          title: 'Propositos',
        ),
        text: "Purpouses");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            body: _buildView(context),
            bottomNavigationBar: const BottonNavWidget()));
  }
}
