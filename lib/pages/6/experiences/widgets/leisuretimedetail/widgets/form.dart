import 'package:flutter/material.dart';
import '../index.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CustomLeisureTimeDetailForm extends StatelessWidget {
  CustomLeisureTimeDetailForm({Key? key, this.ctrl, required this.experience})
      : super(key: key);

  final LeisureTimeDetailController? ctrl;
  final _formKey = GlobalKey<FormState>();
  final String experience;

  @override
  Widget build(BuildContext context) {
    Rx<TimeOfDay?> leisureTimeStart = Rx(getFormValue(globalctx.memory["days"],
            currentDay.value, "leisureTimeStart", time) ??
        time);
    Rx<TimeOfDay?> leisureTimeEnd = Rx(getFormValue(globalctx.memory["days"],
            currentDay.value, "leisureTimeEnd", time) ??
        time);
    Rx<double?> leisureTime = Rx(
        ((leisureTimeEnd.value!.hour - leisureTimeStart.value!.hour) * 60 +
                (leisureTimeEnd.value!.minute -
                    leisureTimeStart.value!.minute)) *
            1.0 /
            60);
 

    return Obx(() {
      return Stack(
        children: [
          Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                      "Total Leisure Time: ${getTimeStringFromDouble(leisureTime.value!)} hours",
                      style: KTextSytle(
                              context: context,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)
                          .getStyle()),
                  Obx(() {
                    return CustomFormCounterFieldWidget(
                        initial: getFormValue(globalctx.memory["days"],
                                currentDay.value, "leisureTime", 0)
                            .round() as int,
                        min: 0,
                        max: (leftHours[currentDay.value].value + 1).round()
                            as int,
                        bound: 0,
                        onValueChanged: (value) {
                          setFormValue(globalctx.memory["days"],
                              currentDay.value, "leisureTime", value);
                          // promoteExperience(experience, "promoted");
                        },
                        label: "Leisure Time    ",
                        width: 0.20);
                  }),
                ],
              )),
        ],
      );
    });
  }
}
