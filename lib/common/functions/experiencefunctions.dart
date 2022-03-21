// Experience functions
// ignore_for_file: prefer_function_declarations_over_variables
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:naver_crs/pages/6/experiences/widgets/custom/index.dart';
import '../index.dart';

Function filterSuggestedExperiences = () {
  // Get airport from current destination
  var filteredExperiences = getFilteredExperiences();
  explist.value = <Widget>[];
  for (var exp in filteredExperiences) {
    explist.add(CustomDragableExperience(experience: exp, suggested: true));
  }
};
Function getFilteredExperiences = () {
  processDays();
  // var airport = getDestinationAirport().toString().toUpperCase();
  var experiences = processCatalog("experiences");
  List filteredByDestination = [];
  for (Map item in experiences) {
    List itemList = item.values.toList();
    CatalogDto experience = CatalogDto(itemList);
    if (experience.value["destination"].toString().toLowerCase() ==
        globalDestinationName.value) {
      filteredByDestination.add(experience);
    }
  }
  List filteredByTravelRhytm = filteredByDestination.where((e) {
    // return true;
    if (currentDay.value == 0) {
      return true;
    }
    var tr = getExperienceTravelRhythmByName(e.description)["description"];

    if (currentTravelRhythm.value == "0") {
      return true;
    }

    compareTr = currentDestinationTr["description"];
    if (compareTr == "HARD") {
      return true;
    }
    if (compareTr == "MEDIUM" && tr == "SOFT") {
      return true;
    }
    var rule = tr == compareTr;
    return rule;
  }).toList();
  List filteredByType = filteredByTravelRhytm.where((e) {
    try {
      var compare = currentDestinationType;
      var tr = getExperienceByName(e.description).value["experience_type"];
      var rule = tr == compare;
      return rule;
    } catch (e) {
      log(e);
    }
    return true;
    // return rule;
  }).toList();
  List filteredByKA = filteredByType.where((e) {
    if (currentDay.value == 0) {
      return true;
    }
    return true;
    try {
      var compare = currentTravelRhythm.value;
      String ka1 =
          getExperienceByName(e.description).value["keyActivityType_fk"];
      String ka2 =
          getExperienceByName(e.description).value["keyActivityType_fk2"];
      var rule1 = compare.contains(ka1.toString().toUpperCase());
      var rule2 = compare.contains(ka2.toString().toUpperCase());
      return rule1 || rule2;
    } catch (e) {
      log(e);
    }
    return true;
  }).toList();
  List filteredByPurpose = filteredByKA.where((e) {
    if (currentDay.value == 0) {
      return true;
    }
    return true;
    try {
      var pCode = globalctx.memory["tour"]["purpose"];
      var purposes = processCatalog("purpose").toList();
      var compare = toCatalog(purposes.firstWhere(
          (e) => e["code"].toString() == pCode.toString())).description;
      String p1 = getExperienceByName(e.description).value["purpose_fk"];
      String p2 = getExperienceByName(e.description).value["purpose_fk2"];
      var rule1 =
          compare.toString().toUpperCase() == p1.toString().toUpperCase();
      var rule2 =
          compare.toString().toUpperCase() == p2.toString().toUpperCase();
      return rule1 || rule2;
    } catch (e) {
      log(e);
    }
    return true;
  }).toList();
  List filteredByBudget = filteredByPurpose.where((e) {
    return true;
  }).toList();
  List filteredByMaxCapacity = filteredByBudget.where((e) {
    return true;
  }).toList();

  List filteredByExpMode = filteredByMaxCapacity.where((e) {
    if (globalDestinationName.value.toString().toUpperCase() !=
            "galapagos".toString().toUpperCase() &&
        globalDestinationName.value.toString().toUpperCase() !=
            "amazon".toString().toUpperCase()) {
      return true;
    }

    return true;
  }).toList();
  Iterable filteredByAirport = filteredByExpMode;
  var filteredBySuggested = filteredByAirport.where((e) {
    return getExperienceState(e.description) == "suggested";
  }).toList();
  return filteredBySuggested;
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
  if (globalctx.experiences[currentDay.value].contains(experience)) {
    var index = globalctx.experiences[currentDay.value]
        .indexWhere((element) => element == experience);
    globalctx.experiences[currentDay.value].removeAt(index);
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
  List<CatalogDto> filteredByDestination = [];
  for (Map item in experiences) {
    List itemList = item.values.toList();
    CatalogDto exp = CatalogDto(itemList);
    filteredByDestination.add(exp);
  }
  CatalogDto experienceData =
      filteredByDestination.firstWhere((e) => e.description == experience);
  globalctx.memory["promoted"] ??= {};
  globalctx.memory["promoted"]["day"] ??= {};
  globalctx.memory["promoted"]["day"][currentDay.value] ??= {};
  globalctx.memory["promoted"]["day"][currentDay.value][experience] =
      experienceData.toJson();
};
Function setExperienceState = (experience, state) {
  globalctx.states["experiences"][currentDay.value] ??= {}.obs;
  globalctx.states["experiences"][currentDay.value][experience] ??= {}.obs;
  globalctx.states["experiences"][currentDay.value][experience]["state"] =
      state;
  // proccessExperiences();
  if (state == "selected") {
    moveExperience(experience);
  }
  filterSuggestedExperiences();
};
Function getExperienceState = (experience) {
  globalctx.states["experiences"][currentDay.value] ??= {}.obs;
  globalctx.states["experiences"][currentDay.value][experience] ??= {}.obs;
  var state =
      globalctx.states["experiences"][currentDay.value][experience]["state"];
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
Function moveExperience = (String experience) {
  globalctx.experiences[currentDay.value] ??= [];
  globalctx.experienceDragData.value[currentDay.value] ??= [];
  var expData = getExperienceByName(experience).value;
  if (!globalctx.experiences[currentDay.value].contains(experience)) {
    globalctx.experiences[currentDay.value].add(experience);
    globalctx.experienceDragData.value[currentDay.value]!
        .add(DragExperienceOptionWidget(experience: experience));
    var exptime = (parseInt(expData['exptime']) * 1.0) as double;
    accumulatedHours.value += exptime / 60;
  }
};
Function getExperienceTravelRhythmByName = (String experience) {
  var expData = getExperienceValueByName(experience);
  var trData = processCatalog("travel_rhythm").toList();
  var trObject = trData.firstWhere((e) =>
      e["description"].toString().toUpperCase() ==
      expData["travel_rhythm"].toString().toUpperCase());
  return trObject;
};
Function getExperienceValueByName = (String experience) {
  var result;
  try {
    result = getExperienceByName(experience).value;
  } catch (e) {
    log(e);
  }
  return result;
};
Function getExperienceByName = (String experience) {
  var result;
  try {
    var experiences = processCatalog("experiences").toList();
    result = toCatalog(experiences.firstWhere(
        (element) => element["description"].toString() == experience));
  } catch (e) {
    log(e);
  }
  return result;
};
