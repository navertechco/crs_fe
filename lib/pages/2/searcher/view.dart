import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'index.dart'; 
import 'widgets/index.dart';

class SearcherPage extends GetView<SearcherController> {
  const SearcherPage({Key? key}) : super(key: key);

  // 内容页
  Widget _buildView() {
    return WillPopScope(
      onWillPop: () async => false,
      child: SearcherWidget(
        ctrl: controller,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildView();
  }
}
