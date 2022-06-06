// ignore_for_file: unused_field, must_be_immutable, file_names

import 'package:flutter/material.dart';
import '../index.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';
import 'package:naver_crs/pages/3/tour/controller.dart';

class RightWidget extends StatelessWidget {
  const RightWidget({
    Key? key,
    required this.profile,
    this.ctrl,
  }) : super(key: key);

  final TourController? ctrl;
  final bool profile;

  @override
  Widget build(BuildContext context) {
    return CustomTourInformationForm(ctrl: ctrl, profile: profile);
  }
}
