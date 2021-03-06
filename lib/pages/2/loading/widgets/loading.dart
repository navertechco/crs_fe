import 'package:flutter/material.dart';
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
                      left: MediaQuery.of(context).size.width * isMobile * 0.4,
                      top: MediaQuery.of(context).size.height * isMobile * 0.7),
                  child: Column(
                    children: [
                      RoundedFormButton(
                          label: "New Tour",
                          height: 0.07,
                          fontSize: 10,
                          onPressed: () async {
                            var res = await getCatalogs(["ALL"]);
                            if (res) {
                              await newTour();
                            }
                            setContext("readonly", false);
                          }),
                      SizedBox(
                        height: MediaQuery.of(context).size.height *
                            isMobile *
                            0.02,
                      ),
                      RoundedFormButton(
                          label: "Find Tour",
                          height: 0.07,
                          fontSize: 10,
                          onPressed: () async {
                            await getCatalogs(["experiences"]);
                            await getTour(context, tourId: 0, cb: (data) {
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
