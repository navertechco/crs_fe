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
 

    var index = getDestinationIndex(
        globalDestinationName.value, globalDestinationType.value);
    Rx<dynamic> keyActivities = Rx(getFormValue(
        globalctx.memory["destinations"], index, "keyActivities", <String>[]));

    Rx<dynamic> destinationOption = Rx(getFormValue(
        globalctx.memory["destinations"], index, "destinationOption", "0"));

    

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
                  if (keyActivities.value.length > 0)
                    InputChip(
                      deleteIcon: Icon(Icons.cancel),
                      label: Text(
                          " Key Activities: ${keyActivities.value.toString().replaceAll("[", "").replaceAll("]", "")}"),
                      onSelected: (bool value) {},
                      onDeleted: () {
                        keyActivities.value = [];
                      },
                    ),
                  if (destinationOption.value != "0")
                    InputChip(
                      deleteIcon: Icon(Icons.cancel),
                      label: Text(
                          "Destination Options: ${destinationOption.value}"),
                      onSelected: (bool value) {},
                      onDeleted: () {
                        destinationOption.value = "0";
                      },
                    ),
                  if (currentTravelRhythm.value != "0")
                    InputChip(
                      deleteIcon: Icon(Icons.cancel),
                      label: Text(
                          "Travel Rhythm: ${findTravelRhythmDescription(parseInt(currentTravelRhythm.value))}"),
                      onSelected: (bool value) {},
                      onDeleted: () {
                        if (globalDestinationName.value != "galapagos") {
                          currentTravelRhythm.value = "3";
                          currentTravelRhythm.value = "3";
                          filterSuggestedExperiences();
                        }
                      },
                    ),
                ],
              );
            })
          ],
        ));
  }
}
