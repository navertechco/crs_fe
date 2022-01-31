// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import '../../../index.dart';
import '../index.dart';
import 'index.dart';

/// hello
class ExperiencesWidget extends GetView<ExperiencesController> {
  const ExperiencesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children:   [
      CustomLeftOptionsWidget(ctrl:controller),
      CustomRightDayWidget(ctrl:controller),
    ]);
  }
}



