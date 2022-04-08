import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import '../../../../../index.dart';

class TravelChips extends HookWidget {
  const TravelChips({Key? key, required this.ctrl, required this.counter})
      : super(key: key);
  final ValueNotifier<int> counter;
  final ExperiencesController ctrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.25,
        child: Column(
          children: [
            CustomTitleWidget(
                fontWeight: FontWeight.bold,
                label: "Filtered Experiences by:",
                color: Colors.white),
            Obx(() {
              return Column(
                children: [
                  if (currentDestinationKeyActivities.value.isNotEmpty)
                    InputChip(
                      deleteIcon: Icon(Icons.cancel),
                      label: Text(
                          " Key Activities: ${currentDestinationKeyActivities.value.toString().replaceAll("[", "").replaceAll("]", "")}"),
                      onSelected: (bool value) {},
                      onDeleted: () {
                        currentDestinationKeyActivities.value = [];
                        filterExperiences();
                      },
                    ),
                  // if (currentDestinationOption.value != "0")
                  //   InputChip(
                  //     deleteIcon: Icon(Icons.cancel),
                  //     label: Text(
                  //         "Destination Options: ${currentDestinationOption.value}"),
                  //     onSelected: (bool value) {},
                  //     onDeleted: () {
                  //       currentDestinationOption.value = "0";
                  //       filterExperiences();
                  //     },
                  //   ),
                  if (currentTravelRhythm.value != "0")
                    InputChip(
                      deleteIcon: Icon(Icons.cancel),
                      label: Text(
                          "Travel Rhythm: ${findTravelRhythmDescription(parseInt(currentTravelRhythm.value))}"),
                      onSelected: (bool value) {},
                      onDeleted: () {
                        currentTravelRhythm.value = "0";
                        filterExperiences();
                      },
                    ),
                ],
              );
            })
          ],
        ));
  }
}
