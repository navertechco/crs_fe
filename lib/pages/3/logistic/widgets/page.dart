// ignore_for_file: file_names, import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../index.dart';
import './index.dart';

class LogisticFormPage extends GetView<StatelessWidget> {
  const LogisticFormPage({
    Key? key,
    this.ctrl,
  }) : super(key: key);

  final LogisticController? ctrl;
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
