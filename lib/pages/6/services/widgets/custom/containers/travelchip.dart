import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

class TravelChips extends HookWidget {
  const TravelChips({Key? key, required this.ctrl, required this.counter})
      : super(key: key);
  final ValueNotifier<int> counter;
  final ServicesController ctrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.25,
        child: Column(
          children: [
            CustomTitleWidget(
                fontWeight: FontWeight.bold,
                label: "Filtered Services by:",
                color: Colors.white),
            Obx(() {
              var d = arrivalDate.value;
              return Column(
                children: [
                  if (currentDestinationKeyActivities != null)
                    InputChip(
                      deleteIcon: Icon(Icons.cancel),
                      label: Text(
                          " Key Activities: ${currentDestinationKeyActivities.value.toString().replaceAll("[", '').replaceAll("]", '')}"),
                      onSelected: (bool value) {},
                      onDeleted: () {
                        clearedKA[currentDay.value] = true;
                        clearKA();
                        filterSuggestedServices();
                      },
                    ),
                  // if (currentDayOption.value != "0")
                  //   InputChip(
                  //     deleteIcon: Icon(Icons.cancel),
                  //     label: Text(
                  //         "Destination Options: ${currentDayOption.value}"),
                  //     onSelected: (bool value) {},
                  //     onDeleted: () {
                  //  currentDayOption.value = "0";
                  //  filterServices();
                  //     },
                  //   ),
                  if (currentTravelRhythm.value != "0")
                    InputChip(
                      deleteIcon: Icon(Icons.cancel),
                      label: Text(
                          "Travel Rhythm: ${findTravelRhythmDescription(parseInt(currentTravelRhythm.value))}"),
                      onSelected: (bool value) {},
                      onDeleted: () {
                        clearedHours[currentDay.value] = true;
                        clearHours();
                        filterSuggestedServices();
                      },
                    ),
                ],
              );
            })
          ],
        ));
  }
}
