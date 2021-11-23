import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/widgets/index.dart';
import 'widgets/index.dart';

import 'index.dart';

class ResumePage extends GetView<ResumeController> {
  const ResumePage({Key? key}) : super(key: key);

  Widget _buildView(BuildContext? _context, {height}) {
    return ContentLayoutWidget(
        height: height,
        background: "assets/custom/img/resume.png",
        child: const ResumeWidget(),
        text: "");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 2,
            child: _buildView(context, height: 2)),
      )),
    );
  }
}
