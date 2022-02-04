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
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.44,
      width: MediaQuery.of(context).size.width * 0.2,
      child: Scrollbar(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Obx(() {
            var list = <Widget>[].obs;

            list = <Widget>[].obs;
            globalctx.suggested.value = [];
            var exps = [];
            experiences = getContext("experiences");
            List filtered = experiences
                    .where((e) => e["destination"]
                        .toString()
                        .toUpperCase()
                        .contains(destination.value.toUpperCase()))
                    .toList() ??
                [];
            var airport =
                getAirport(destination.value).toString().toUpperCase();
            Iterable filteredairport = [];
            if (destination.value == "arrival") {
              filteredairport =
                  filtered.where((e) => e["title"].contains(airport));
            }

            for (var experience in filteredairport) {
              globalctx.suggested.add(experience);
              if (!exps.contains(experience)) {
                list.add(CustomDragableExperience(
                    experience: experience["title"], suggested: suggested));
                exps.add(experience);
              }
            }

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
