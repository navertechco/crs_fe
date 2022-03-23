import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:interval_time_picker/interval_time_picker.dart'
    as interval_time_picker;
import 'package:naver_crs/common/index.dart';
import '../index.dart';

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

    // ignore: prefer_function_declarations_over_variables
    Function saveTimePicker = (start, end, lt, save) async {
      TimeOfDay? value = await interval_time_picker.showIntervalTimePicker(
            context: context,
            initialTime: time,
          ) ??
          time;
      if (save.toString().toLowerCase().contains("start") &&
              (value.hour <= end.value!.hour) &&
              (value.minute <= end.value!.minute) ||
          save.toString().toLowerCase().contains("end") &&
              (value.hour >= start.value!.hour) &&
              (value.minute >= start.value!.minute)) {
        if (save.toString().toLowerCase().contains("start")) {
          start.value = value;
        } else {
          end.value = value;
        }
        lt.value = ((end.value!.hour - start.value!.hour) * 60 +
                (end.value!.minute - start.value!.minute)) *
            1.0 /
            60;
        if (lt.value > leftHours[currentDay.value].value) {
          showCustomDialog(
            context,
            Text("Too Many Selected Hours !!!!",
                style: KTextSytle(
                        context: context,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)
                    .getStyle()),
            "Close",
            backgroundColor: Colors.white,
            buttonColor: Colors.black,
          );
        } else {
          leftHours[currentDay.value].value -= lt.value;
          accumulatedHours[currentDay.value].value += lt.value;
          setFormValue(
              globalctx.memory["days"], currentDay.value, "$save", value);

          setFormValue(globalctx.memory["days"], currentDay.value,
              "leisureTime", lt.value);

          if (leftHours[currentDay.value].value == 0) {
            expDraggable.value = 0;
          } else {
            expDraggable.value = 1;
          }
        }
      } else {
        showCustomDialog(
          context,
          Text("Error of Time Setup !!!!",
              style: KTextSytle(
                      context: context,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)
                  .getStyle()),
          "Close",
          backgroundColor: Colors.white,
          buttonColor: Colors.black,
        );
      }
    };

    return Obx(() {
      var lt = leisureTime;
      return Stack(
        children: [
          Form(
              key: _formKey,
              child: Column(
                children: [
                  Text("Total Leisure Time: $leisureTime hours",
                      style: KTextSytle(
                              context: context,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)
                          .getStyle()),
                  TextButton(child: Obx(() {
                    return Text(
                        "Starts at: ${leisureTimeStart.value.toString().replaceAll("TimeOfDay", "").replaceAll("(", "").replaceAll(")", "")}",
                        style: KTextSytle(
                                context: context,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)
                            .getStyle());
                  }), onPressed: () async {
                    await saveTimePicker(leisureTimeStart, leisureTimeEnd,
                        leisureTime, "leisureTimeStart");
                  }),
                  TextButton(
                      child: Text(
                          "Ends at: ${leisureTimeEnd.value.toString().replaceAll("TimeOfDay", "").replaceAll("(", "").replaceAll(")", "")}",
                          style: KTextSytle(
                                  context: context,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)
                              .getStyle()),
                      onPressed: () async {
                        await saveTimePicker(leisureTimeStart, leisureTimeEnd,
                            leisureTime, "leisureTimeEnd");
                      }),
                ],
              )),
        ],
      );
    });
  }
}
