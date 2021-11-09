import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/widgets/index.dart';
import 'widgets/index.dart';

import 'index.dart';

class OpportunitiesPage extends GetView<OpportunitiesController> {
  const OpportunitiesPage({Key? key}) : super(key: key);

  Widget _buildView(BuildContext? _context) {
    return const ContentLayoutWidget(
        child: OpportunitiesWidget(
          title: 'Propositos',
        ),
        text: "Opportunities");
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
