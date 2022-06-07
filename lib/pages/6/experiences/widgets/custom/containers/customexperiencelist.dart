// ignore_for_file: unused_local_variable, prefer_function_declarations_over_variables

import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';

class CustomExperiencesListWidget extends StatelessWidget {
  final ExperiencesController ctrl;
  const CustomExperiencesListWidget({
    Key? key,
    required this.ctrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        // width: MediaQuery.of(context).size.width * 0.1,
        child: Column(children: [
      CustomTitleWidget(
          fontWeight: FontWeight.bold,
          label: "Suggested Experiences",
          color: Colors.white),
      const Divider(
        color: Colors.black,
        height: 20,
        thickness: 2,
        indent: 5,
        endIndent: 5,
      ),
      Scrollbar(
          child: SingleChildScrollView(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: Obx(() {
                    var d = arrivalDate.value;
                    return Scrollbar(
                        child: SingleChildScrollView(
                            child: Column(
                                children: experienceSelectedDragData.value)));
                  }))))
    ]));
  }
}
