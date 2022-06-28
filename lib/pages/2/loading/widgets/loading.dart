import 'package:flutter/material.dart';
import '../index.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';

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
          background: "assets/images/1x/loading.png",
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
                          height: 0.1,
                          fontSize: 5,
                          onPressed: () async {
                            setContext("readonly", false);
                            await newTour();
                          }),
                      SizedBox(
                        height: MediaQuery.of(context).size.height *
                            isMobile *
                            0.02,
                      ),
                      RoundedFormButton(
                          label: "Find Tour",
                          height: 0.1,
                          fontSize: 5,
                          onPressed: () {
                            getCatalogs(["experiences"]);
                            getTour(context, tourId: 0, cb: (data) {
                              if (data.length > 0) {
                                globalctx.memory["tours"] = data;
                                if (0 == 0) {
                                  Get.toNamed("/Searcher");
                                } else {
                                  Get.toNamed("/Tour");
                                }
                              }
                            });
                          }),
                    ],
                  )),
            ],
          )),
    );
  }
}
