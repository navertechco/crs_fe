import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'index.dart';
import '../../index.dart';
import 'widgets/index.dart';

class LoadingPage extends GetView<LoadingController> {
  const LoadingPage({Key? key}) : super(key: key);

  // 内容页
  Widget _buildView() {
    var quote = true;
    if (!quote) {
      Timer(const Duration(seconds: 3), () {
        Get.toNamed('/Loading');
      });
    }

    return const LoadingWidget();
  }

  @override
  Widget build(BuildContext context) {
    setContext('size', Get);
    return _buildView();
  }
}
