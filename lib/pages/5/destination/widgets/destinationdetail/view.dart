import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../index.dart';
import 'index.dart';
import 'widgets/index.dart';

class DestinationDetailPage extends GetView<DestinationDetailController> {
  const DestinationDetailPage({Key? key, this.destination}) : super(key: key);
  final destination;
  Widget _buildView(BuildContext? _context) {
    return ContentLayoutWidget(
        background: "assets/custom/img/destination.png",
        child: DestinationDetailWidget(destination: destination),
        text: "<   DestinationDetail");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildView(context),
    );
  }
}
