import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../../../index.dart';
import '../../index.dart';

class CustomBodyDaysWidget extends HookWidget {
  final ExperiencesController ctrl;
  final ValueNotifier<int> counter;
  const CustomBodyDaysWidget({
    Key? key,
    required this.ctrl,
    required this.counter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ctrl.state.memory = globalctx.memory;

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.8,
              left: MediaQuery.of(context).size.width * 0.675),
          child: CustomFooterWidget(ctrl: ctrl, counter: counter),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.065,
              left: MediaQuery.of(context).size.width * 0.05),
          child: CustomContentWidget(ctrl: ctrl),
        ),
      ],
    );
  }
}
