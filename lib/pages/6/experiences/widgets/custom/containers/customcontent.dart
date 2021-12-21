import 'package:flutter/material.dart';

import '../../index.dart';

class CustomContentWidget extends StatelessWidget {
  const CustomContentWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          CustomSugestedExperiencesWidget(),
          CustomSelectedExperiencesWidget(),
        ],
      ),
    );
  }
}
