// Experience functions

// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter/widgets.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:naver_crs/pages/6/experiences/widgets/custom/index.dart';

import '../index.dart';

Function filterSuggestedExperiences = () {
  // Get airport from current destination
  var filteredExperiences = getFilteredDestination();
  list.value = <Widget>[];
  for (var exp in filteredExperiences) {
    list.add(CustomDragableExperience(experience: exp, suggested: true));
  }
};

Function removeExperienceFromArray = (array, item) {
  if (array.contains(item)) {
    var index = array.indexOf(item);
    array.value.removeAt(index);
    if (globalctx.experienceDragData.value[currentDay.value]!.isNotEmpty) {
      if (globalctx.experienceDragData.value[currentDay.value]!.length ==
          array.value.length) {
        globalctx.experienceDragData.value[currentDay.value]!.removeAt(index);
      } else {
        var newIndex = index > 0 ? index - 1 : 0;
        globalctx.experienceDragData.value[currentDay.value]!
            .removeAt(newIndex);
      }
    }
  }
};

Function removeExperience = (experience) {
  removeExperienceFromArray(globalctx.selectedExperiences, experience);
  removeExperienceFromArray(globalctx.promotedExperiences, experience);
};

Function resetExperiences = () {
  for (Map experience in experiences) {
    CatalogDto expCatalog = toCatalog(experience);
    setExperienceState(expCatalog.description, "suggested");
  }
};

Function deleteExperience = (experience) {
  if (globalctx.experiences.contains(experience)) {
    var index =
        globalctx.experiences.indexWhere((element) => element == experience);
    globalctx.experiences.removeAt(index);
    globalctx.experienceDragData.value[currentDay.value]!.removeAt(index);
  }
};

Function filterExperienceList = (data, day) {
  String travelRhythm = data["travelRhythm"];
  List? currentList = globalctx.promotedExperiences[day];
  Iterable filtered =
      currentList!.where((e) => e["travelRhythm"] == travelRhythm);

  // for (var experience in filtered) {}

  globalctx.promotedExperiences[day] = filtered.toList();
};

Function proccessExperiences = () {
  var experiences = processCatalog("experiences");

  for (Map item in experiences) {
    List itemList = item.values.toList();
    CatalogDto exp = CatalogDto(itemList);

    var state = getExperienceState(exp.description);
    states[state][exp.description] = true;
  }
};

Function promoteDayExperience = (experience) {
  var experiences = processCatalog("experiences");
  List filteredByDestination = [];

  for (Map item in experiences) {
    List itemList = item.values.toList();
    CatalogDto exp = CatalogDto(itemList);
    filteredByDestination.add(exp);
  }

  var experienceData =
      filteredByDestination.firstWhere((e) => e.description == experience);

  globalctx.memory["promoted"] ??= {};
  globalctx.memory["promoted"]["day"] ??= {};
  globalctx.memory["promoted"]["day"][currentDay.value] ??= {};
  globalctx.memory["promoted"]["day"][currentDay.value][experience] =
      experienceData;
};

Function setExperienceState = (experience, state) {
  globalctx.states["experiences"][experience] ??= {}.obs;
  globalctx.states["experiences"][experience]["state"] = state;
  proccessExperiences();
  filterSuggestedExperiences();
};

Function getExperienceState = (experience) {
  globalctx.states["experiences"][experience] ??= {}.obs;
  var state = globalctx.states["experiences"][experience]["state"];
  state ??= "suggested";
  return state;
};

Function getPromotedExperiencesByDayAndKA = (day) {
  // Get promoted experiences by day and KA
  // List promoted = states["promoted"].entries.toList();
  // var filtered = promoted.where((e) {
  //   return experiences.where((f) {
  //     return f["title"] == e.key;
  //   }).isNotEmpty;
  // });

  return true;
};
