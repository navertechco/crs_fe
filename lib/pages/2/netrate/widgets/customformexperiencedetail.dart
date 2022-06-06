import 'package:flutter/material.dart';
import '../index.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';
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
    var tour = globalctx.memory["tour"];
    var destinations = tour["destinations"];
    var destinationDay = destinations;
    var destination = destinationDay[destinationindex.toString()];
    var daysData = destination["daysData"];
    var days = daysData.entries.toList();
    var day = days[dayindex].value;
    var dayexps = day['experiences'];
    List<Widget> list = [];

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
