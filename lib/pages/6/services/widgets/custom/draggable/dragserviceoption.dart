import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';
import '../../index.dart';

class DragServiceOptionWidget extends StatelessWidget {
  final String service;
  const DragServiceOptionWidget({
    Key? key,
    required this.service,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var state = Rx(getServiceState(service));
      return state.value != "suggested"
          ? Row(
              children: [
                ServiceOptionWidget(
                    height: Get.height * 0.075,
                    width: Get.width * 0.2,
                    service: service),
                state.value != "promoted"
                    ? TextButton(
                        onPressed: () {
                          setServiceState(service, "suggested");
                        },
                        child: Image.asset("assets/images/1x/redmark.png",
                            width: Get.width * 0.02),
                      )
                    : TextButton(
                        onPressed: () {
                          setServiceState(service, "suggested");
                        },
                        child: Image.asset("assets/images/1x/greencheck.png",
                            width: Get.width * 0.02),
                      )
              ],
            )
          : Text('');
    });
  }
}
