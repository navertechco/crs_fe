import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
    return const Align(
      alignment: Alignment.bottomCenter,
      child:
          BodyWidget(background: "assets/custom/img/loading.png", children: []),
    );
  }
}
