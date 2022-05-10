import 'package:flutter/material.dart';

import '../../../index.dart';
import 'customformexperience.dart';

class CustomFormExperiencesDetailWidget extends StatelessWidget {
  const CustomFormExperiencesDetailWidget({
    Key? key, 
    required this.indexes,
  }) : super(key: key); 
  final List<int> indexes;
  @override
  Widget build(BuildContext context) {
    var destinationindex = indexes[0];
    var dayindex = indexes[1];
    var destinationDay = globalctx.memory["destinations"];
    var destination = destinationDay[destinationindex.toString()];
    var daysData = destination["daysData"];
    var days = daysData.entries.toList();
    var day = days[dayindex].value;
    var dayexps = day['experiences'];
    List<CustomFormExperienceRowWidget> list = [];

    for (var i = 0; i < dayexps.length; i++) {
      list.add(CustomFormExperienceRowWidget(
          indexes: [destinationindex, dayindex, i]));
    }

    return Padding(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
      child: Column(
        children: list,
      ),
    );
  }
}
