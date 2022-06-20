import 'package:flutter/material.dart';
import '../index.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';
import 'widgets/index.dart';

class DestinationDetailPage extends GetView<DestinationDetailController> {
  const DestinationDetailPage(
      {Key? key,
      required this.destination,
      required this.type,
      required this.index})
      : super(key: key);
  final destination;
  final type;
  final index;
  Widget _buildView(BuildContext? _context) {
    return ContentLayoutWidget(
        background: "assets/images/1x/destination.png",
        child: DestinationDetailWidget(
            type: type,
            index: index,
            destination: destination,
            ctrl: Get.put(DestinationDetailController())),
        text: "<   DestinationDetail");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildView(context),
    );
  }
}
