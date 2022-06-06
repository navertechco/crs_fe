import 'package:flutter/material.dart';
import '../index.dart';
import 'package:naver_crs/index.dart';

import 'package:naver_crs/index.dart';

class CustomSugestedExperiencesWidget extends StatelessWidget {
  const CustomSugestedExperiencesWidget({
    Key? key,
    required this.ctrl,
  }) : super(key: key);
  final ExperiencesController ctrl;
  @override
  Widget build(BuildContext context) {
    return CustomExperiencesListWidget(ctrl: ctrl);
  }
}
