import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';
import 'widgets/widgets.dart';

class HomePage extends GetView<HomeController> {
  // 内容页
  Widget _buildView() {
    return HelloWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildView(),
    );
  }
}
