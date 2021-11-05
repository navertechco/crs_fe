import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfileLayoutWidget extends StatelessWidget {
  const ProfileLayoutWidget({Key? key, this.child, this.text}) : super(key: key);
  final dynamic child;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(children: [
        Padding(
          padding: EdgeInsets.only(bottom: Get.height * 0.81),
          child: SvgPicture.asset(
            "assets/custom/svg/images/Header.svg",
            fit: BoxFit.fitWidth,
            height: Get.height,
            width: Get.width,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: child,
        ),
      ]),
    );
  }
}
