import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'index.dart';
import '../../index.dart';
import 'widgets/index.dart';

class LoadingPage extends GetView<LoadingController> {
  const LoadingPage({Key? key}) : super(key: key);

  // 内容页
  Widget _buildView() {
    RxBool catalogs = false.obs;
    getCatalog(["ALL"]).then((value) => {catalogs.value = value});

    return Obx(() {
      if (!catalogs.value) {
        return CustomProgressIndicatorWidget();
      }
      return LoadingWidget(
        state: controller.state,
      );
      // return CustomProgressIndicatorWidget();
    });
  }

  @override
  Widget build(BuildContext context) {
    setContext('size', Get);
    return _buildView();
  }
}
