import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

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
                  if (currentDestinationKeyActivities.isNotEmpty)
                    InputChip(
                      deleteIcon: Icon(Icons.cancel),
                      label: Text(
                          " Key Activities: ${currentDestinationKeyActivities.value.toString().replaceAll("[", '').replaceAll("]", '')}"),
                      onSelected: (bool value) {},
                      onDeleted: () {
                        clearedKA[currentDay.value] = true;
                        clearKA();
                        filterExperiences();
                      },
                    ),
                  if (currentTravelRhythm.value != "0")
                    InputChip(
                      deleteIcon: Icon(Icons.cancel),
                      label: Text(
                          "Travel Rhythm: ${findTravelRhythmDescription(parseInt(currentTravelRhythm.value))}"),
                      onSelected: (bool value) {},
                      onDeleted: () {
                        clearedHours[currentDay.value] = true;
                        clearHours();
                        filterExperiences();
                      },
                    ),
                  if (currentTravelRhythm.value == "0")
                    CustomFormDropDownFieldWidget(
                      value: currentTravelRhythm.value,
                      onSaved: (value) {
                        setFormValue(globalctx.memory["destinations"],
                            getDestinationIndexByDay(), "travel_rhythm", value);
                        clearedHours[currentDay.value] = false;
                        currentTravelRhythm.value = value!;
                        filterExperiences();
                      },
                      onChanged: (value) {
                        setFormValue(globalctx.memory["destinations"],
                            getDestinationIndexByDay(), "travel_rhythm", value);
                        clearedHours[currentDay.value] = false;
                        currentTravelRhythm.value = value!;
                        filterExperiences();
                      },
                      hintText: "Travel Rhythm",
                      data: findCatalog("travel_rhythm"),
                    ),
                ],
              );
            })
          ],
        ));
  }
}
