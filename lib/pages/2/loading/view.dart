import 'package:flutter/material.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';
import 'widgets/index.dart';

class LoadingPage extends GetView<LoadingController> {
  const LoadingPage({Key? key}) : super(key: key);

  // 内容页
  Widget _buildView() {
    return WillPopScope(
      onWillPop: () async => false,
      child: LoadingWidget(
        ctrl: controller,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildView();
  }
}
