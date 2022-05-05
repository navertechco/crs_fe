// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../index.dart';
import 'package:interval_time_picker/interval_time_picker.dart'
    as interval_time_picker;

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key? key,
    required this.service,
  }) : super(key: key);

  final service;

  @override
  Widget build(BuildContext context) {
    var expData = getServiceByName(service).value;
    Rx<TimeOfDay?> timeStart = Rx(getFormValue(
            globalctx.memory["days"][currentDay.value],
            service,
            "timeStart",
            time) ??
        time);

    return Column(
      children: [
        Text(service.toString().split("-")[0],
            style: KTextSytle(
                    context: context,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 204, 164, 61))
                .getStyle()),
        Row(
          children: [
            Text("Open Destinations: ",
                style: KTextSytle(
                        context: context,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 204, 164, 61))
                    .getStyle()),
            Text("${expData["openDestinations"]}",
                style: KTextSytle(
                        context: context,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)
                    .getStyle()),
          ],
        ),
        Row(
          children: [
            Text("Open Time: ",
                style: KTextSytle(
                        context: context,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 204, 164, 61))
                    .getStyle()),
            Text("${expData["openTime"]}",
                style: KTextSytle(
                        context: context,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)
                    .getStyle()),
          ],
        ),
        Row(
          children: [
            Text("Close Time: ",
                style: KTextSytle(
                        context: context,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 204, 164, 61))
                    .getStyle()),
            Text("${expData["closeTime"]}",
                style: KTextSytle(
                        context: context,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)
                    .getStyle()),
          ],
        ),
        Row(
          children: [
            Text("Duration: ",
                style: KTextSytle(
                        context: context,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 204, 164, 61))
                    .getStyle()),
            Text("${expData["exptime"]} min",
                style: KTextSytle(
                        context: context,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)
                    .getStyle()),
          ],
        ),
        Row(
          children: [
            TextButton(child: Obx(() {
              return Text(
                  "Starts at: ${timeStart.value.toString().replaceAll("TimeOfDay", "").replaceAll("(", "").replaceAll(")", "")}",
                  style: KTextSytle(
                          context: context,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)
                      .getStyle());
            }), onPressed: () async {
              timeStart.value = await interval_time_picker
                  .showIntervalTimePicker(
                context: context,
                initialTime: time,
              )
                  .then((value) {
                globalctx.memory["days"][currentDay.value] ??= {};
                globalctx.memory["days"][currentDay.value][service] ??= {};
                setFormValue(globalctx.memory["days"][currentDay.value],
                    service, "timeStart", value);
                return value;
              });
            }),
          ],
        ),
        Row(
          children: [
            Obx(() {
              return Text(
                  "  Ends at: ${(timeStart.value!.addMinute(expData["exptime"])).toString().replaceAll("TimeOfDay", "").replaceAll("(", "").replaceAll(")", "")}",
                  style: KTextSytle(
                          context: context,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)
                      .getStyle());
            }),
          ],
        )
      ],
    );
  }
}
