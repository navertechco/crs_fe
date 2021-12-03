import 'package:flutter/material.dart'; 
import 'package:get/get.dart';
import 'package:naver_crs/common/widgets/body.dart';
import '../index.dart';

/// Loading
class LoadingWidget extends GetView<LoadingController> {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var multiplier = MediaQuery.of(context).orientation == Orientation.landscape
        ? 0.1
        : 0.09;
    return Align(
      alignment: Alignment.bottomCenter,
      child: BodyWidget(
          background: "assets/custom/img/loading.png",
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.45,
                    top: MediaQuery.of(context).size.height * 0.7),
                child: SizedBox(
                  height: Get.height * multiplier,
                  width: Get.width * multiplier,
                  child: Image.asset(
                    "assets/custom/img/layout.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
