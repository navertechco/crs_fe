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
      Expanded(
        // top: 0,
        // right: 0,
        child: Image.asset(
          "assets/custom/img/layout.png",
          fit: BoxFit.fill,
          height: double.infinity,
          width: double.infinity,
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 100.0),
        child: Positioned(
          child: child,
        ),
      ),
    ]);
  }
}
