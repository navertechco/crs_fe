
import 'package:flutter/material.dart'; 
import '../../../../index.dart';
import '../index.dart';
import 'index.dart';

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
      list.add(Column(
        children: [
          if (globalctx.suggested.contains(experience) && suggested)
            Row(
              children: [
                ExperienceOptionWidget(
                  experience: experience,
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.25,
                ),
                if (globalctx.promoted.contains(experience) && !suggested)
                  Image.asset("assets/custom/img/greencheck.png",
                      width: MediaQuery.of(context).size.width * 0.02),
                if (!globalctx.promoted.contains(experience) && !suggested)
                  Image.asset("assets/custom/img/redmark.png",
                      width: MediaQuery.of(context).size.width * 0.02)
              ],
            ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        ],
      ));
    }
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width * 0.3,
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
