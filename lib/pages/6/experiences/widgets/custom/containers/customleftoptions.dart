import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:naver_crs/pages/6/experiences/widgets/custom/containers/transportfilter.dart';
import 'package:naver_crs/pages/6/experiences/widgets/custom/containers/travelfilter.dart';
import '../../../../../index.dart';
import 'leftHeader.dart';

class CustomLeftOptionsWidget extends HookWidget {
  final ExperiencesController ctrl;
  final ValueNotifier<int> counter;
  const CustomLeftOptionsWidget({
    Key? key,
    required this.ctrl,
    required this.counter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ctrl.state.memory = globalctx.memory;

    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.3,
          left: MediaQuery.of(context).size.width * 0.05),
      child: Column(
        children: [
          LeftHeader(ctrl: ctrl, counter: counter),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Scrollbar(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TransportFilter(ctrl: ctrl),
                    TravelFilter(ctrl: ctrl, counter: counter),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
