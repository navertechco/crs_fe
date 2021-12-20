
import 'package:flutter/material.dart';

import '../../../../../index.dart';
import '../index.dart';

class CustomParentExpererienceWidget extends StatelessWidget {
  const CustomParentExpererienceWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var experiences = getContext("experiences");
    var list = <Widget>[];

    for (var experience in experiences.keys) {
      list.add(CustomExperienceForm(experience: experience));
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width * 0.5,
      child: Scrollbar(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Expanded(
            child: Row(
              children: list,
            ),
          ),
        ),
      ),
    );
  }
}
