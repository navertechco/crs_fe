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
    return Stack(
      children: [
        Form(
            key: _formKey,
            child: Column(
              children: [
                TextButton(
                  child: Obx(() {
                    return Text("Starts at: $leisureTimeStart",
                        style: KTextSytle(
                                context: context,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)
                            .getStyle());
                  }),
                  onPressed: () async {
                    TimeOfDay? value =
                        await interval_time_picker.showIntervalTimePicker(
                      context: context,
                      initialTime: time,
                    );
                    if ((value!.hour <= leisureTimeEnd.value!.hour) &&
                        (value.minute <= leisureTimeEnd.value!.minute)) {
                      leisureTimeStart.value = value;
                      setFormValue(globalctx.memory["days"], currentDay.value,
                          "leisureTimeStart", leisureTimeStart.value);
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
                  },
                ),
                TextButton(
                  child: Obx(() {
                    return Text("Ends at: $leisureTimeEnd",
                        style: KTextSytle(
                                context: context,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)
                            .getStyle());
                  }),
                  onPressed: () async {
                    TimeOfDay? value =
                        await interval_time_picker.showIntervalTimePicker(
                      context: context,
                      initialTime: time,
                    );
                    if ((value!.hour >= leisureTimeStart.value!.hour) &&
                        (value.minute >= leisureTimeStart.value!.minute)) {
                      leisureTimeEnd.value = value;
                      setFormValue(globalctx.memory["days"], currentDay.value,
                          "leisureTimeEnd", leisureTimeEnd.value);
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
                  },
                ),
              ],
            )),
      ],
    );
  }
}
