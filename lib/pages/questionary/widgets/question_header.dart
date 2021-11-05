import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_trivia/common/constants.dart';

import 'question_container.dart';

// ignore: must_be_immutable
class QuestionHeaderWidget extends StatefulWidget {
  QuestionHeaderWidget({Key? key, required this.title}) : super(key: key);
  Obx title;

  @override
  State<QuestionHeaderWidget> createState() => _QuestionHeaderWidgetState();
}

class _QuestionHeaderWidgetState extends State<QuestionHeaderWidget> {
  double left = kSize.width;

  double top = kSize.height;

  @override
  Widget build(BuildContext context) {
    return QuestionContainerWidget(widget: widget);
  }
}
