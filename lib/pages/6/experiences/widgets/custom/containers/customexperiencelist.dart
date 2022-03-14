// ignore_for_file: unused_local_variable, prefer_function_declarations_over_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../index.dart';

class CustomExperiencesListWidget extends StatelessWidget {
  final ExperiencesController ctrl;
  const CustomExperiencesListWidget({
    Key? key,
    required this.ctrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Obx(() {
        return Column(
          children: explist,
        );
      }),
    );
  }
}
