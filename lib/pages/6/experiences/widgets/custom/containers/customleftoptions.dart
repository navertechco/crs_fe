import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import '../../../../../index.dart';
import '../../index.dart';

class CustomBodyDaysWidget extends HookWidget {
  final ExperiencesController ctrl;
  final ValueNotifier<int> counter;
  GlobalKey<FormState> formKey;
  CustomBodyDaysWidget({
    Key? key,
    required this.ctrl,
    required this.counter,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.815,
              left: MediaQuery.of(context).size.width * 0.68),
          child: CustomFooterWidget(
              ctrl: ctrl, counter: counter, formKey: formKey),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.065,
              left: MediaQuery.of(context).size.width * 0.0),
          child: CustomContentWidget(ctrl: ctrl),
        ),
        Obx(() => Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.875,
                  left: MediaQuery.of(context).size.width * 0.05),
              child: Text(
                leftHours[currentDay.value].value < 0
                    ? "You have exceeded the maximum hours planned for this day !!!"
                    : "",
                style: KTextSytle(
                  context: context,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 204, 164, 61),
                ).getStyle(),
              ),
            )),
      ],
    );
  }
}
