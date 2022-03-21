import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/index.dart';
import '../index.dart';
import 'index.dart';

class CustomLeisureTimeDetailForm extends StatelessWidget {
  CustomLeisureTimeDetailForm({Key? key, this.ctrl, required this.experience})
      : super(key: key);

  final LeisureTimeDetailController? ctrl;
  final _formKey = GlobalKey<FormState>();
  final String experience;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
            key: _formKey,
            child: Column(
              children: [
                CustomFormCounterFieldWidget(
                    initial: accumulatedHours[currentDay.value].value,
                    min: 0,
                    max: leftHours[currentDay.value].value,
                    bound: 0,
                    onValueChanged: (value) {},
                    label: "Leisure Time",
                    width: 0.20),
                CustomDayWidget(),
              ],
            )),
      ],
    );
  }
}
