import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:naver_crs/pages/6/experiences/controller.dart';
import 'package:naver_crs/pages/6/experiences/widgets/custom/containers/transportfilter.dart';

// ignore: must_be_immutable
class CustomTopDayWidget extends HookWidget {
  final ExperiencesController ctrl;
  final ValueNotifier<int> counter;
  GlobalKey<FormState> formKey;
  CustomTopDayWidget({
    Key? key,
    required this.ctrl,
    required this.counter,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TransportFilter(ctrl: ctrl, counter: counter, formKey: formKey);
  }
}
