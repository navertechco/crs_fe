import 'package:flutter/material.dart';

import '../../../../../index.dart';
import '../../index.dart';

class CustomSugestedExperiencesWidget extends StatelessWidget {
  const CustomSugestedExperiencesWidget({
    Key? key,
    required this.ctrl,
  }) : super(key: key);
  final ExperiencesController ctrl;
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
            // width: MediaQuery.of(context).size.width * 0.1,
            child: Column(
          children: [
            CustomTitleWidget(
              fontWeight: FontWeight.bold,
              label: "Suggested Experiences\n",
            ),
            const Divider(
              color: Colors.black,
              height: 25,
              thickness: 2,
              indent: 5,
              endIndent: 5,
            ),
            CustomExperiencesListWidget(ctrl: ctrl),
          ],
        )));
  }
}
