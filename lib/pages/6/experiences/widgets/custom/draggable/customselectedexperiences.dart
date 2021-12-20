import 'package:flutter/material.dart';

import '../../../../../index.dart';
import '../../index.dart';

class CustomSelectedExperiencesWidget extends StatelessWidget {
  const CustomSelectedExperiencesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTitleWidget(
          fontWeight: FontWeight.bold,
          label: "Selected Experiences\n______________________________________",
        ),
        Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: const [
                CustomExperiencesListWidget(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}