import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/common/widgets/index.dart';
import 'widgets/index.dart';

import 'index.dart';

class ExperiencesPage extends GetView<ExperiencesController> {
  const ExperiencesPage({Key? key}) : super(key: key);

  Widget _buildView(BuildContext? _context) {
    return ContentLayoutWidget(
        background: "assets/custom/img/activities.png",
        child: const ExperiencesWidget(),
        text: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildView(context),
    );
  }
}
