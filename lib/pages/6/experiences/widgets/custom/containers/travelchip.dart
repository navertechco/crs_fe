import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

class TravelChips extends HookWidget {
  const TravelChips({Key? key}) : super(key: key);

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
                        clearCurrentDestinationKeyActivities();
                        filterExperiences();
                      },
                    ),
                  if (currentDestinationKeyActivities.isEmpty)
                    CustomFormMultiDropDownFieldWidget(
                      value: getFormValue(
                          globalctx.memory["destinations"],
                          currentDestinationIndex.value,
                          "key_activities", <String>[]),
                      onSaved: (values) {},
                      onChanged: (values) {
                        if (values == null) return;

                        if (values.length <= 3) {
                          kaMemory.value = [];
                          var length = values.length;

                          for (var i = 0; i < length; i++) {
                            kaMemory.add(findCatalog("key_activity")
                                .toList()
                                .where((e) => e["code"] == values[i])
                                .toList()[0]["description"]);
                          }
                          setFormValue(
                              globalctx.memory["destinations"],
                              currentDestinationIndex.value,
                              "key_activities",
                              kaMemory.value);
                          currentDestinationKeyActivities.value =
                              kaMemory.value;
                        }
                        filterExperiences();
                      },
                      hintText: "Key Activities",
                      data: findCatalog("key_activity"),
                    ),
                  if (currentTravelRhythm.value != "0")
                    InputChip(
                      deleteIcon: Icon(Icons.cancel),
                      label: Text(
                          "Travel Rhythm: ${findTravelRhythmDescription(parseInt(currentTravelRhythm.value))}"),
                      onSelected: (bool value) {},
                      onDeleted: () {
                        clearedHours[currentDay.value] = true;
                        clearCurrentDayHours();
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
