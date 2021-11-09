import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/widgets/index.dart';
import 'widgets/index.dart';

import 'index.dart';

class DestinationsPage extends GetView<DestinationsController> {
  const DestinationsPage({Key? key}) : super(key: key);

  Widget _buildView(BuildContext? _context) {
    return const ContentLayoutWidget(
        child: DestinationsWidget(
          title: 'Propositos',
        ),
        text: "Destinations");
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
