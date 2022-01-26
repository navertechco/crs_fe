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
    getCatalog(["ALL"]);
    return Obx(() {
      while (catalogs.value==null) {
        return CustomProgressIndicatorWidget();
      }
      return LoadingWidget(
        state: controller.state,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildView();
  }
}
