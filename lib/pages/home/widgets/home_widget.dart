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
    return Align(
      alignment: Alignment.bottomCenter,
      child: BodyWidget(background: "assets/custom/img/home.png", children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.5),
        Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            GestureDetector(
              onTap: () {
                Get.toNamed("/Signin");
              },
              child: SvgPicture.asset(
                "assets/custom/svg/images/IngresarButton.svg",
                width: MediaQuery.of(context).size.width * 0.1,
                height: MediaQuery.of(context).size.height * 0.1,
                // fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            // GestureDetector(
            //   onTap: () {
            //     Get.toNamed("/Signup");
            //   },
            //   child: SvgPicture.asset(
            //     "assets/custom/svg/images/RegistrarseButton.svg",
            //     width: MediaQuery.of(context).size.width * 0.1,
            //     height: MediaQuery.of(context).size.height * 0.1,
            //     // fit: BoxFit.fill,
            //   ),
            // ),
          ],
        ),
      ]),
    );
  }
}
