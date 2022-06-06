import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:naver_crs/pages/6/services/widgets/custom/containers/transportfilter.dart';
import '../../../controller.dart';

class CustomTopDestinationWidget extends HookWidget {
  final ServicesController ctrl;
  final ValueNotifier<int> counter;
  GlobalKey<FormState> formKey;
  CustomTopDestinationWidget({
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
