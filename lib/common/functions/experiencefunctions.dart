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
  List filtered = [];
  for (Map item in experiences) {
    List itemList = item.values.toList();
    CatalogDto experience = CatalogDto(itemList);
    if (experience.value["destination"].toString().toLowerCase() == "all") {
      filtered.add(experience);
    }
    if (experience.value["destination"].toString().toLowerCase() ==
        globalDestinationName.value) {
      filtered.add(experience);
    }
  }
  List filteredByTravelRhytm = filtered.where((e) {
    return true;
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
  List filteredByAirport = filteredByExpMode;
  List filteredBySuggested = filteredByAirport.where((e) {
    if (e.description == "Leisure Time") {
      return true;
    }
    return getExperienceState(e.description) == "suggested";
  }).toList();
  Iterable result = filteredBySuggested;
  return result;
};

Function resetCurrentDay = () {
  var experiences = globalctx.states["experiences"][currentDay.value].entries;
  for (var experience in experiences) {
    removeExperience(experience.key);
  }
  accumulatedHours[currentDay.value].value = 0.0;
  leftHours[currentDay.value].value = totalHours[currentDay.value].value;
  initializeHours();
  // resetLeisureTime();
};

Function resetExperiences = () {
  globalctx.experiences.value = {};
  globalctx.experienceDragData.value = {};
  expDraggable.value = 1;

  for (Map experience in experiences) {
    CatalogDto expCatalog = toCatalog(experience);
    removeExperience(expCatalog.description);
  }
  resetLeisureTime();
};
Function resetLeisureTime = () {
  initializeHours();
  var value = getFormValue(
      globalctx.memory["days"], currentDay.value, "leisureTime", 0);

  var state = getExperienceState("Leisure Time");
  setFormValue(globalctx.memory["days"], currentDay.value, "leisureTime", 0);
  setFormValue(
      globalctx.memory["days"], currentDay.value, "leisureTimeStart", time);
  setFormValue(
      globalctx.memory["days"], currentDay.value, "leisureTimeEnd", time);

  if (state == "promoted") {
    processHour(value);
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
Function removeExperience = (experience) {
  downgradeExperienceDays(experience);
};
Function promoteExperience = (experience) {
  upgradeExperienceDays(experience);

  List<CatalogDto> filtered = [];
  for (Map item in experiences) {
    List itemList = item.values.toList();
    CatalogDto exp = CatalogDto(itemList);
    filtered.add(exp);
  }
  CatalogDto experienceData =
      filtered.firstWhere((e) => e.description == experience);
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
Function moveExperience = (String experience) {
  globalctx.experiences[currentDay.value] ??= [];
  globalctx.experienceDragData.value[currentDay.value] ??= [];
  if (!globalctx.experiences[currentDay.value].contains(experience)) {
    globalctx.experiences[currentDay.value].add(experience);
    globalctx.experienceDragData.value[currentDay.value]!
        .add(DragExperienceOptionWidget(experience: experience));
  }
};
Function upgradeExperienceDays = (String experience) {
  var state = getExperienceState(experience);
  if (state == "selected") {
    var value = calculateExperienceDays(experience);
    processHour(value);
  }
  setExperienceState(experience, "promoted");
};
Function downgradeExperienceDays = (String experience) {
  var state = getExperienceState(experience);
  if (state == "promoted") {
    var value = calculateExperienceDays(experience);
    if (experience == "Leisure Time") {
      value = getFormValue(
          globalctx.memory["days"], currentDay.value, "leisureTime", 0);
    }
    processHour(-value);
  }
  setExperienceState(experience, "suggested");
};
Function processHour = (value) {
  if (leftHours[currentDay.value].value > 0) {
    if (leftHours[currentDay.value].value <=
        totalHours[currentDay.value].value) {
      accumulatedHours[currentDay.value].value =
          accumulatedHours[currentDay.value].value + value;
      initializeHours();
    }
  }
};
Function initializeHours = () {
  leftHours[currentDay.value] ??= 0.0.obs;
  accumulatedHours[currentDay.value] ??= 0.0.obs;
  totalHours[currentDay.value] ??= 0.0.obs;
  var index = getDestinationIndex(
      globalDestinationName.value, globalDestinationType.value);
  var travelRhythm = (getFormValue(globalctx.memory["destinations"], index,
      "travelRhythm", globalDestinationName.value == "galapagos" ? "3" : "1"));
  if (travelRhythm == "1") {
    totalHours[currentDay.value].value = 6.0;
  }
  if (travelRhythm == "2") {
    totalHours[currentDay.value].value = 8.0;
  }
  if (travelRhythm == "3") {
    totalHours[currentDay.value].value = 10.0;
  }
  leftHours[currentDay.value].value = totalHours[currentDay.value].value -
      accumulatedHours[currentDay.value].value;
};
Function calculateExperienceDays = (String experience) {
  var expData = getExperienceByName(experience).value;
  var exptime = (parseInt(expData['exptime']) * 1.0) as double;
  return exptime / 60;
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
    result = toCatalog(expList.firstWhere(
        (element) => element["description"].toString() == experience));
  } catch (e) {
    log(e);
  }
  return result;
};
Function updateDraggableExperiences = () {
  if (globalctx.promotedExperiences.keys.contains("Leisure Time")) {
    destDraggable.value = 0;
  }
};
