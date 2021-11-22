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
    final size = Get;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          children: [
            Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
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
          ],
        ),
      ),
    );
  }
}
