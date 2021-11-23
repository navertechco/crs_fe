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
    var multiplier = MediaQuery.of(context).orientation == Orientation.landscape
        ? 0.1
        : 0.09;
    return Align(
      alignment: Alignment.bottomCenter,
      child: BodyWidget(background: "assets/custom/img/home.png", children: [
        SizedBox(height: MediaQuery.of(context).size.height * multiplier * 5),
        Column(
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height * multiplier * 0.1),
            GestureDetector(
              onTap: () {
                Get.toNamed("/Signin");
              },
              child: SvgPicture.asset(
                "assets/custom/svg/images/login_button.svg",
                width: MediaQuery.of(context).size.width * multiplier * 2,
                // fit: BoxFit.fill,
              ),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * multiplier * 0.1),
            GestureDetector(
              onTap: () {
                Get.toNamed("/Signup");
              },
              child: SvgPicture.asset(
                "assets/custom/svg/images/register_button.svg",
                width: MediaQuery.of(context).size.width * multiplier * 2,
                // fit: BoxFit.fill,
              ),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * multiplier * 2),
      ]),
    );
  }
}
