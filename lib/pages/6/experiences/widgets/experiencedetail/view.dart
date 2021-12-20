import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../index.dart';
import 'index.dart';
import 'widgets/index.dart';

class ExperienceDetailPage extends GetView<ExperienceDetailController> {
  const ExperienceDetailPage({Key? key, this.experience}) : super(key: key);
  final experience;
  Widget _buildView(BuildContext? _context) {
    return ContentLayoutWidget(
        background: "assets/custom/img/experience.png",
        child: ExperienceDetailWidget(experience: experience),
        text: "<   ExperienceDetail");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildView(context),
    );
  }
}
