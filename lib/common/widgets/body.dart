import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/constants.dart';

/// Body
class BodyWidget extends GetView<StatelessWidget> {
  const BodyWidget({Key? key, this.background, this.children})
      : super(key: key);
  final String? background;
  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          children: [
            Stack(
              fit: StackFit.expand,
              children: [
                SvgPicture.asset(
                  background!,
                  fit: BoxFit.fill,
                  height: size.height,
                ),
                SingleChildScrollView(
                  child: Column(
                    children: children!,
                  ),
                ),
              ],
            ),
            Positioned(
              top: size.height * 0.92,
              left: 0,
              child: SvgPicture.asset(
                "assets/custom/svg/images/gold_diagonal_right_semicircle.svg",
                fit: BoxFit.fill,
                width: size.width * 0.10,
              ),
            ),
            Positioned(
              top: size.height * 0.15,
              left: size.width * 0.9,
              child: SvgPicture.asset(
                "assets/custom/svg/images/gold_left_semicircle.svg",
                fit: BoxFit.fill,
                width: size.width * 0.10,
              ),
            ),
            Positioned(
              top: size.height * 0.05,
              left: 0,
              child: SvgPicture.asset(
                "assets/custom/svg/images/gold_right_semicircle.svg",
                fit: BoxFit.fill,
                width: size.width * 0.10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
