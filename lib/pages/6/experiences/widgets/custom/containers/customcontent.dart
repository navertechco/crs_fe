
import 'package:flutter/material.dart';

import '../../index.dart';

class CustomContentWidget extends StatelessWidget {
  const CustomContentWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Row(
        children: [
          CustomSugestedExperiencesWidget(),
          CustomSelectedExperiencesWidget(),
        ],
      ),
    );
  }
}

