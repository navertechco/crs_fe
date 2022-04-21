// Experience functions
// ignore_for_file: prefer_function_declarations_over_variables
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl/intl.dart';
import 'package:naver_crs/pages/6/experiences/widgets/custom/index.dart';
import '../index.dart';

Function filterSuggestedExperiences = () {
  processDays();
  filterExperiences();
  clearHours();
  clearKA();
};

Function filterExperiences = () {
  var filteredExperiences = getFilteredExperiences();
  updateDragExperiences(filteredExperiences);
};

Function updateDragExperiences = (filteredExperiences) {
  explist.value = <Widget>[];
  for (var exp in filteredExperiences) {
    explist.add(CustomDragableExperience(experience: exp, suggested: true));
  }
};

Function getFilteredExperiences = () {
  List filtered = getFiltered();

  List filteredByType = filtered.where((e) {
    if (e.value["experience_type"] == "meal") {
      return true;
    }

    if (e.description == "Leisure Time") {
      return true;
    }
    try {
      var compare = currentDestinationType;
      var tr = getExperienceByName(e.description).value["experience_type"];
      var rule = tr == compare;
      return rule;
    } catch (e) {
      return true;
    }
    // return rule;
  }).toList();
  List filteredByKA = filteredByType.where((e) {
    if (currentDestinationKeyActivities.value.isEmpty) {
      return true;
    }
    if (currentDay.value == 0 || e.description == "Leisure Time") {
      return true;
    }

    var destKa = getDestinationKa(
        globalDestinationName.value, globalDestinationType.value);
    String ka1 = getExperienceByName(e.description)
        .value["keyActivityType_fk"]
        .toString();
    String ka2 = getExperienceByName(e.description)
        .value["keyActivityType_fk2"]
        .toString();
    var rule1 = destKa.contains(ka1);
    var rule2 = destKa.contains(ka2);
    return rule1 || rule2;
  }).toList();
  List filteredByPurpose = filteredByKA.where((e) {
    if (currentDay.value == 0 || e.description == "Leisure Time") {
      return true;
    }
    var purposes = globalctx.memory["tour"]["purpose"];
    String p1 = getExperienceByName(e.description).value["purpose_fk"];
    String p2 = getExperienceByName(e.description).value["purpose_fk2"];
    var rule1 = purposes.contains(p1.toString().toUpperCase());
    var rule2 = purposes.contains(p2.toString().toUpperCase());
    return rule1 || rule2;
  }).toList();
  List filteredByOpenDays = filteredByPurpose.where((e) {
    if (currentDay.value == 0 || e.description == "Leisure Time") {
      return true;
    }
    try {
      var dateName = openDays[DateFormat('E').format(currentDate.value)];
      var open = getExperienceByName(e.description)
          .value["openDays"]
          .toString()
          .split(",");
      var rule = open.contains(dateName);
      return rule;
    } catch (e) {
      return true;
    }
  }).toList();
  List filteredByBudget = filteredByOpenDays.where((e) {
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
  List filteredByLeft = filteredBySuggested.where((e) {
    // return true;

    if (e.description == "Leisure Time") {
      return true;
    }
    var total = totalHours[currentDay.value] ?? 0.0.obs;
    var acc = accumulatedHours[currentDay.value] ?? 0.0.obs;
    var currentLeft = (total.value - acc.value) * 60;
    var expTime = getExperienceByName(e.description).value["exptime"] ?? 600;
    var rule = expTime <= currentLeft;
    var rule2 = (expTime - currentLeft) <= 30;
    return rule || rule2;
  }).toList();

  List filterByArrivalHour = filteredByLeft.where((e) {
    if (currentDay.value == 0) {
      if (e.description == "Leisure Time") {
        return true;
      }
      if (parseHour(e.value["openTime"]) >= parseHour(arrivalHour.value)) {
        return true;
      }
      return false;
    }
    var endHour = endHours[currentDay.value].toString();

    return true;
  }).toList();

  filterByArrivalHour.sort((a, b) {
    var aTime = a.value["exptime"];
    var bTime = b.value["exptime"];
    return aTime.compareTo(bTime);
  });

  Iterable result = filterByArrivalHour;

  return result;
};
//////////////////////////////////////////////////////////////////////////////////////
Function getFiltered = () {
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
  return filtered;
};
Function resetCurrentDay = () {
  try {
    var experiences = globalctx.states["experiences"][currentDay.value].entries;
    for (var experience in experiences) {
      removeExperience(experience.key);
    }
    accumulatedHours[currentDay.value].value = 0.0;
    leftHours[currentDay.value].value = totalHours[currentDay.value].value;
    initializeHours();
    resetLeisureTime();
  } catch (e) {
    log(e);
  }
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
    processHour(-value);
  }
  setExperienceState("Leisure Time", "suggested");
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
  accumulatedHours[currentDay.value].value =
      accumulatedHours[currentDay.value].value + value;
  initializeHours();
};

Function initializeHours = () {
  leftHours[currentDay.value] ??= 0.0.obs;
  accumulatedHours[currentDay.value] ??= 0.0.obs;
  totalHours[currentDay.value] ??= 0.0.obs;
  endHours[currentDay.value] ??= time.obs;
  totalHours[currentDay.value].value = getMaxTrValue(currentTravelRhythm.value);
  leftHours[currentDay.value].value = totalHours[currentDay.value].value -
      accumulatedHours[currentDay.value].value;
  endHours[currentDay.value].value =
      time.addHour(totalHours[currentDay.value].value.round() as int);
  clearHours();
  clearKA();
};
Function calculateExperienceDays = (String experience) {
  var expData = getExperienceByName(experience).value;
  var exptime = (parseInt(expData['exptime']) * 1.0) as double;
  return exptime / 60;
};

Function getExperienceTravelRhythmByName = (String experience) {
  var expData = getExperienceValueByName(experience);
  var trData = findCatalog("travel_rhythm").toList();
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

Function clearHours = () {
  clearedHours[currentDay.value] ??= false;
  if (clearedHours[currentDay.value]) {
    currentTravelRhythm.value = "0";
    totalHours[currentDay.value].value = 10.0;
    leftHours[currentDay.value].value = totalHours[currentDay.value].value -
        accumulatedHours[currentDay.value].value;
  }
};
Function clearKA = () {
  clearedKA[currentDay.value] ??= false;
  if (clearedKA[currentDay.value]) {
    currentDestinationKeyActivities.value = [];
  }
};
