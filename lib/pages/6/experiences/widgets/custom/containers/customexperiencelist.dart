import 'package:flutter/material.dart';
import '../../../../../index.dart';
import '../../index.dart';

class CustomExperiencesListWidget extends StatelessWidget {
  const CustomExperiencesListWidget({
    Key? key,
    this.suggested = false,
  }) : super(key: key);
  final bool suggested;
  @override
  Widget build(BuildContext context) {
    var list = <Widget>[];
    var experiences = getContext("experiences");
    for (var experience in experiences.keys) {
      if (suggested) {
        globalctx.suggested.add(experience);
      }
      list.add(CustomDragableExperience(
          experience: experience, suggested: suggested));
    }
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.44,
      width: MediaQuery.of(context).size.width * 0.2,
      child: Scrollbar(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: list,
          ),
        ),
      ),
    );
  }
}
