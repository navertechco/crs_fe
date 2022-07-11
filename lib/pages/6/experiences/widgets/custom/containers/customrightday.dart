import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:naver_crs/pages/6/experiences/widgets/custom/containers/transportfilter.dart';

// ignore: must_be_immutable
class CustomTopDayWidget extends HookWidget {
  const CustomTopDayWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DayExpFilter();
  }
}
