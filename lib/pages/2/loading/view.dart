import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'index.dart';
import '../../index.dart';
import 'widgets/index.dart';

class LoadingPage extends GetView<LoadingController> {
  const LoadingPage({Key? key}) : super(key: key);

  // 内容页
  Widget _buildView() {
    var catalogs = Rx(getContext("catalogs"));

    return LoadingWidget(
      ctrl: controller,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildView();
  }
}
