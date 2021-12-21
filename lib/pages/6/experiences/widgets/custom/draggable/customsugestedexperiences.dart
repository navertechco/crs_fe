import 'package:flutter/material.dart';

import '../../../../../index.dart';
import '../../index.dart';

class CustomSugestedExperiencesWidget extends StatelessWidget {
  const CustomSugestedExperiencesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTitleWidget(
          fontWeight: FontWeight.bold,
          label: "Sugested Experiences\n______________________________________",
        ),
        Scrollbar(
          child: SingleChildScrollView(
            child: CustomExperiencesListWidget(suggested: true),
          ),
        ),
      ],
    );
  }
}
