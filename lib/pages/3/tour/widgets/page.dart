// ignore_for_file: file_names, import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';
import '../index.dart';
import 'index.dart';
import 'package:get/get.dart';
import 'package:naver_crs/index.dart';


class TourFormPage extends GetView<StatelessWidget> {
  const TourFormPage({
    Key? key,
    this.ctrl,
  }) : super(key: key);

  final TourController? ctrl;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          LeftWidget(),
          RightWidget(ctrl: ctrl, profile: false),
        ],
      ),
    );
  }
}
