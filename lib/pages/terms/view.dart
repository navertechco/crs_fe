import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';
import 'widgets/widgets.dart';

class TermsPage extends GetView<TermsController> {
  const TermsPage({Key? key}) : super(key: key);

  // 内容页
  Widget _buildView() {
    return const TermsWidget();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child:Scaffold(
      body: _buildView(),
    ));
  }
}
