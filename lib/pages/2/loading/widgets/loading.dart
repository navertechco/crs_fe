import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/index.dart';
import 'package:naver_crs/common/widgets/layouts/index.dart';
import '../index.dart';

/// Loading
class LoadingWidget extends GetView<LoadingController> {
  const LoadingWidget({Key? key}) : super(key: key);

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
                child: RoundedFormButton(
                    label: "Quote",
                    onTap: () {
                      Get.toNamed("/Tour");
                    }),
              ),
            ],
          )),
    );
  }
}
