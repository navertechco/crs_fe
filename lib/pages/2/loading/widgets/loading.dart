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
  RxBool newtour = true.obs;
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
                  child: Column(
                    children: [
                      RoundedFormButton(
                          label: "New Tour",
                          height: 0.07,
                          fontSize: 5,
                          onTap: () {
                            setContext("readonly", false);
                            newTour();

                          }),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      RoundedFormButton(
                          label: "Find Tour",
                          height: 0.07,
                          fontSize: 5,
                          onTap: () {
                            getTour(context, tourId: 0);
                          }),
                    ],
                  )),
            ],
          )),
    );
  }
}
