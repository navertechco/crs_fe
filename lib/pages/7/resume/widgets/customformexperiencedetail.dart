import 'package:flutter/material.dart';
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
    try {
      var destId = indexes[0];
      var destDay = indexes[1];
      var promoted = globalctx.memory["promoted"][destDay];

      List<CustomFormExperienceRowWidget> list = [];

      for (var i = 0; i < promoted.length; i++) {
        list.add(CustomFormExperienceRowWidget(indexes: [destId, destDay, i]));
      }

      return Padding(
        padding:
            EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
        child: Column(
          children: list,
        ),
      );
    } catch (e) {
      return Text("Error of CustomFormExperiencesDetailWidget: $e");
    }
  }
}
