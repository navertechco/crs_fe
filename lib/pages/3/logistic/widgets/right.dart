// ignore_for_file: unused_field, must_be_immutable, file_names

import 'package:flutter/material.dart';
import '../index.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';
import 'package:naver_crs/index.dart';
import 'package:naver_crs/index.dart';

import 'index.dart';

class RightWidget extends StatelessWidget {
  const RightWidget({
    Key? key,
    required this.profile,
    this.ctrl,
  }) : super(key: key);

  final LogisticController? ctrl;
  final bool profile;

  @override
  Widget build(BuildContext context) {
    return CustomLogisticInformationForm(ctrl: ctrl, profile: profile);
  }
}
