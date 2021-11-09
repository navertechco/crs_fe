import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfileLayoutWidget extends StatelessWidget {
  const ProfileLayoutWidget({Key? key, this.child, this.text})
      : super(key: key);
  final dynamic child;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Expanded(
        // top: 0,
        // right: 0,
        child: SvgPicture.asset(
          "assets/custom/svg/images/gold_black_rectangle.svg",
          fit: BoxFit.cover,
          height: Get.height * 0.2,
          width: double.infinity,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: Positioned(
          child: child,
        ),
      ),
    ]);
  }
}
