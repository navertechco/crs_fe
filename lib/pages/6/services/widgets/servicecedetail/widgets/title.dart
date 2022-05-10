// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../index.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key? key,
    required this.service,
  }) : super(key: key);

  final service;

  @override
  Widget build(BuildContext context) {
    var srvData = getServiceByName(service).value;
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
            Text("Service Name: ",
                style: KTextSytle(
                        context: context,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 204, 164, 61))
                    .getStyle()),
            Text("${findProp(srvData, ["servicename", "hotelname"])}",
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
            Text("Description: ",
                style: KTextSytle(
                        context: context,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 204, 164, 61))
                    .getStyle()),
            Text("${findProp(srvData, ["roomcategory", "observations"])}",
                style: KTextSytle(
                        context: context,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)
                    .getStyle()),
          ],
        ),
      ],
    );
  }
}
