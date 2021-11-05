import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/widgets/body.dart';
import '../index.dart';

/// Home
class HomeWidget extends GetView<HomeController> {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BodyWidget(
        background: "assets/custom/svg/images/black_vertical_rectangle.svg",
        children: [
          SizedBox(height: Get.height * 0.1),
          SvgPicture.asset(
            "assets/custom/svg/images/HomeLogo.svg",
            width: MediaQuery.of(context).size.width * 0.5,
          ),
          SizedBox(height: Get.height * 0.1),
          Column(
            children: [
              SizedBox(height: Get.height * 0.01),
              GestureDetector(
                onTap: () {
                  Get.toNamed("/Signin");
                },
                child: SvgPicture.asset(
                  "assets/custom/svg/images/login_button.svg",
                  width: MediaQuery.of(context).size.width * 0.5,
                  // fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: Get.height * 0.01),
              GestureDetector(
                onTap: () {
                  Get.toNamed("/Signup");
                },
                child: SvgPicture.asset(
                  "assets/custom/svg/images/register_button.svg",
                  width: MediaQuery.of(context).size.width * 0.5,
                  // fit: BoxFit.fill,
                ),
              ),
            ],
          )
        ]);
  }
}
