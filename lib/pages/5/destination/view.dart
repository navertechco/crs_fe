import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../index.dart';
import 'index.dart';
import 'widgets/index.dart';

class DestinationPage extends GetView<DestinationController> {
  const DestinationPage({Key? key}) : super(key: key);

  Widget _buildView(BuildContext? _context) {
    return ContentLayoutWidget(
        background: "assets/custom/img/stardestination.png",
        child: const DestinationWidget(),
        text: "<   Destination");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildView(context),
    );
  }
}