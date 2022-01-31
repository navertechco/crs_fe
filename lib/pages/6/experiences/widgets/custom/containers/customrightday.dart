import 'package:flutter/material.dart';
import 'package:naver_crs/pages/6/experiences/controller.dart';
import '../index.dart';

class CustomRightDayWidget extends StatelessWidget {
  final ExperiencesController ctrl;
  CustomRightDayWidget({
    Key? key,
    required this.ctrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.3,
          left: MediaQuery.of(context).size.width * 0.375),
      child: Column(
        children: [
          CustomHeaderWidget(),
          CustomContentWidget(),
          CustomFooterWidget(ctrl:ctrl),
        ],
      ),
    );
  }
}
