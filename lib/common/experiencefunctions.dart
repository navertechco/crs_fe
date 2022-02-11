
// Experience functions

// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter/widgets.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:naver_crs/pages/6/experiences/widgets/custom/index.dart';

import 'index.dart';

Function findDestination = (destination) {
  var promotedDestinations = globalctx.promotedDestinations.value;
  var result = "departure";
  var index =
      promotedDestinations.indexWhere((element) => element == destination);
  if (index == -1) {
    if (destination == "arrival") {
      result = "arrival";
    }
  } else {
    result = promotedDestinations[index];
  }
  return result;
};
Function filterSuggestedExperiences = () {
  // Get airport from current destination
  var filteredExperiences = getFiltered(destination.value);
  // Reset suggested memory and suggested render list

  list.value = <Widget>[];
  // Add New Suggested Render Components to list
  for (var experience in filteredExperiences) {
    list.add(CustomDragableExperience(experience: experience, suggested: true));
  }
};

Function removeFromArray = (array, item) {
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
  removeFromArray(globalctx.selectedExperiences, experience);
  removeFromArray(globalctx.promotedExperiences, experience);
};

Function resetExperiences = () {
  for (var experience in experiences) {
    setExperienceState(experience["title"], "suggested");
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
  List? currentList = globalctx.promotedExperiences.value[day];
  Iterable filtered =
      currentList!.where((e) => e["travelRhythm"] == travelRhythm);

  // for (var experience in filtered) {}

  globalctx.promotedExperiences.value[day] = filtered.toList();
};

Function proccessExperiences = () {
  for (var experience in experiences) {
    var state = getExperienceState(experience["title"]);
    states[state][experience["title"]] = true;
  }
};

Function promoteDayExperience = (experience) {
  Map<String, dynamic> experienceData =
      experiences.firstWhere((e) => e["title"] == experience);
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
  return state == null ? "suggested" : state;
};

Function getPromotedExperiencesByDayAndKA = (day) {
  // Get promoted experiences by day and KA
  List promoted = states["promoted"].entries.toList();
  var filtered = promoted.where((e) {
    return experiences.where((f) {
      return f["title"] == e.key;
    }).isNotEmpty;
  });

  return true;
};


Function getExperiences = (String destination,
    String experience,
    List<int>? keyActivities,
    List<int>? travelRhythms,
    int? destinationOption) async {
  var res = await fetchhandler(kDefaultSchema, kDefaultServer,
      kDefaultServerPort, kDefaultExperiencePath, 'POST', {
    "data": {
      "destination": destination,
      "experience": experience,
      "key_activities": keyActivities ?? [],
      "travel_rhythms": travelRhythms ?? [],
      "destination_option": destinationOption
    }
  });

  if (res['state'] == true) {
    setContext("experiences", res['data']);
    return true;
  } else {
    return false;
  }
};