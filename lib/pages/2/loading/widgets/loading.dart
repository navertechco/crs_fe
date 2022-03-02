import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../index.dart';
import '../../../index.dart';

/// Loading
// ignore: must_be_immutable
class LoadingWidget extends GetView<LoadingController> {
  LoadingWidget({
    Key? key,
    required this.ctrl,
  }) : super(key: key);
  LoadingController ctrl;
  RxBool newtour = false.obs;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: BodyLayoutWidget(
          background: "assets/custom/img/loading.png",
          child: Stack(
            children: [
              Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.4,
                      top: MediaQuery.of(context).size.height * 0.7),
                  child: Obx(() {
                    return Column(
                      children: [
                        if (newtour.value)
                          RoundedFormButton(
                              label: "New Tour",
                              height: 0.07,
                              fontSize: 5,
                              onTap: () {
                                setContext("readonly", false);
                                Get.toNamed("/Tour");
                              }),
                        if (newtour.value)
                          SizedBox(
                            child: TextButton(
                              onPressed: () => newtour.value = !newtour.value,
                              child: const Text(
                                "Find tour?",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        if (!newtour.value)
                          RoundedFormField(
                              onChanged: (value) => ctrl.state.tourId = value!,
                              hintText: 'Find Tour',
                              keyboardType: TextInputType.number),
                        if (!newtour.value)
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                        if (!newtour.value)
                          RoundedFormButton(
                              label: "Find Tour",
                              height: 0.07,
                              fontSize: 5,
                              onTap: () {
                                ctrl.getTour(context,
                                    tourId: int.parse(ctrl.state.tourId));
                              }),
                        if (!newtour.value)
                          SizedBox(
                            child: TextButton(
                              onPressed: () => newtour.value = !newtour.value,
                              child: const Text(
                                "New tour?",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                      ],
                    );
                  })),
            ],
          )),
    );
  }
}
