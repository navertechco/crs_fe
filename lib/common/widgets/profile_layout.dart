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
    return Stack(fit: StackFit.expand, children: [
      Positioned(
        top: 0,
        left: -1,
        child: SvgPicture.asset(
            "assets/custom/svg/images/gold_black_rectangle.svg",
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width),
      ),
      // Padding(
      //   padding: const EdgeInsets.only(top: 100.0),
      //   child: Positioned(
      //     child: child,
      //   ),
      // ),
    ]);
  }
}
