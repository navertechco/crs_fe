import 'package:flutter/material.dart';
import '../index.dart';
import 'package:naver_crs/index.dart';
import '../../../controller.dart';

class CustomContentWidget extends StatelessWidget {
  const CustomContentWidget({
    Key? key,
    required this.ctrl,
  }) : super(key: key);
  final ServicesController ctrl;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomSugestedServicesWidget(ctrl: ctrl),
        CustomSelectedServicesWidget(),
      ],
    );
  }
}
