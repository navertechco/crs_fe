import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
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
    var list = <Widget>[].obs;

    list = <Widget>[].obs;
    globalctx.suggested.value = [];
    for (var destination in globalctx.promotedDestinations.value) {
      getExperiences(destination, "", null, null, null);
      var experiences = getContext("experiences");

      for (var experience in experiences) {
        globalctx.suggested.add(experience);
        list.add(CustomDragableExperience(
            experience: experience["title"], suggested: suggested));
      }
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.44,
      width: MediaQuery.of(context).size.width * 0.2,
      child: Scrollbar(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Obx(() {
            while (list.value.isEmpty) {
              return Text("");
            }
            return Column(
              children: list.value,
            );
          }),
        ),
      ),
    );
  }
}
