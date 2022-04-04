import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../../../index.dart';
import '../../index.dart';

class CustomBodyDaysWidget extends HookWidget {
  final ExperiencesController ctrl;
  final ValueNotifier<int> counter;
  GlobalKey<FormState> formKey;
  CustomBodyDaysWidget({
    Key? key,
    required this.ctrl,
    required this.counter,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ctrl.state.memory = globalctx.memory;

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.815,
              left: MediaQuery.of(context).size.width * 0.68),
          child: CustomFooterWidget(
              ctrl: ctrl, counter: counter, formKey: formKey),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.065,
              left: MediaQuery.of(context).size.width * 0.0),
          child: CustomContentWidget(ctrl: ctrl),
        ),
      ],
    );
  }
}
