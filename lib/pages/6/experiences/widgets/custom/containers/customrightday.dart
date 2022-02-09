import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:naver_crs/common/index.dart';
import 'package:naver_crs/pages/6/experiences/controller.dart';
import '../index.dart';

class CustomRightDayWidget extends HookWidget {
  final ExperiencesController ctrl;
  final ValueNotifier<int> counter;
  CustomRightDayWidget({
    Key? key,
    required this.ctrl,
    required this.counter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    

    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.29,
          left: MediaQuery.of(context).size.width * 0.375),
      child: Column(
        children: [
          CustomHeaderWidget(),
          CustomContentWidget(ctrl: ctrl),
          CustomFooterWidget(ctrl: ctrl, counter: counter),
        ],
      ),
    );
  }
}
