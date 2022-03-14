import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:naver_crs/pages/6/experiences/controller.dart';
import 'package:naver_crs/pages/6/experiences/widgets/custom/containers/leftHeader.dart';
import 'package:naver_crs/pages/6/experiences/widgets/custom/containers/transportfilter.dart';
import 'package:naver_crs/pages/6/experiences/widgets/custom/containers/travelchip.dart';

class CustomTopDayWidget extends HookWidget {
  final ExperiencesController ctrl;
  final ValueNotifier<int> counter;
  const CustomTopDayWidget({
    Key? key,
    required this.ctrl,
    required this.counter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.1,
        left: MediaQuery.of(context).size.width * 0.07,
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width * 1,
        child: Stack(
          children: [
            LeftHeader(ctrl: ctrl, counter: counter),
            TransportFilter(ctrl: ctrl, counter: counter),
          ],
        ),
      ),
    );
  }
}
