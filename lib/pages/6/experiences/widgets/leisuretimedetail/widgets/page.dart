// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import '../index.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';
import 'package:naver_crs/index.dart';
import 'package:naver_crs/index.dart';

class LeisureTimeDetailWidget extends GetView<LeisureTimeDetailController> {
  const LeisureTimeDetailWidget({Key? key, this.experience}) : super(key: key);
  final experience;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.0,
                top: MediaQuery.of(context).size.height * 0.0),
            child: Column(
              children: [
                TitleWidget(experience: experience),
                CustomLeisureTimeDetailForm(experience: experience),
                KeypadWidget(experience: experience),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
