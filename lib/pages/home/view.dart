import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/index.dart';

import 'index.dart';
import 'widgets/index.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  // 内容页
  Widget _buildView() {
    return const HomeWidget();
  }

  @override
  Widget build(BuildContext context) {
    setContext('size', Get);
    return _buildView();
  }
}
