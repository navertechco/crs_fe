import 'package:flutter/material.dart';
import '../index.dart';
import 'package:naver_crs/index.dart';

class CustomSugestedServicesWidget extends StatelessWidget {
  const CustomSugestedServicesWidget({
    Key? key,
    required this.ctrl,
  }) : super(key: key);
  final ServicesController ctrl;
  @override
  Widget build(BuildContext context) {
    return CustomServicesListWidget(ctrl: ctrl);
  }
}
