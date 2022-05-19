// Experience functions
// ignore_for_file: prefer_function_declarations_over_variables
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl/intl.dart';
import 'package:naver_crs/pages/6/experiences/widgets/custom/index.dart';
import '../index.dart';

filterSuggestedExperiences() {
  processDays();
  filterExperiences();
  clearHours();
  clearKA();
}

filterExperiences() {
  getFilteredExperiences();
  updateSelectedDragExperiences();
}

updateSelectedDragExperiences() {
  experienceSelectedDragData.value = <Widget>[];
  for (var experience in filteredExperiences) {
    experienceSelectedDragData.value
        .add(DragableExperience(experience: experience, suggested: true));
  }
}

getFilteredExperiences() {
  filteredExperiences = getExpFiltered();
  var idx = getDestinationIndexByDay();
  var sub = getFormValue(globalctx.memory["destinations"], idx, "sub", null);
  var destination =
      getFormValue(globalctx.memory["destinations"], idx, "destination", null);
  var destData = getDestinationValueByName(destination);
  globalctx.experiences[currentDay.value] ??= [];
  globalctx.experiences[currentDay.value] = [];
  experiencePromotedDragData.value = <Widget>[];
  filteredExperiences = filteredExperiences.where((e) {
    var state = getExperienceState(e.description);
    if (state == "promoted") {
      globalctx.experiences[currentDay.value].add(e.description);
      experiencePromotedDragData.value
          .add(DragExperienceTarget(experience: e.description));
      return false;
    }
    return true;
  }).toList();
  //FILTER BY SUB
  filteredExperiences = filteredExperiences.where((e) {
    if (sub != null && sub != "0") {
      var subs = destData[9]["subs"];
      if (e.value["sub"] != null) {
        var subName =
            filterCatalog(subs, "code", int.parse(sub))[0]["description"];
        var rule = subName == e.value["sub"];
        return rule;
      }
    }
    return true;
  }).toList();

  filteredExperiences = filteredExperiences.where((e) {
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
  filteredExperiences = filteredExperiences.where((e) {
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
  filteredExperiences = filteredExperiences.where((e) {
    if (e.value["experience_type"] == "meal") {
      return true;
    }
    if (currentDay.value == 0 || e.description == "Leisure Time") {
      return true;
    }
    var purposes = globalctx.memory["tour"]["purposes"];
    String p1 = getExperienceByName(e.description).value["purpose_fk"];
    String p2 = getExperienceByName(e.description).value["purpose_fk2"];
    var rule1 = purposes.contains(p1);
    var rule2 = purposes.contains(p2);
    return rule1 || rule2;
  }).toList();
  filteredExperiences = filteredExperiences.where((e) {
    if (e.value["experience_type"] == "meal") {
      return true;
    }
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
  filteredExperiences = filteredExperiences.where((e) {
    return true;
  }).toList();
  filteredExperiences = filteredExperiences.where((e) {
    return true;
  }).toList();
  filteredExperiences = filteredExperiences.where((e) {
    if (globalDestinationName.value.toString().toUpperCase() !=
            "galapagos".toString().toUpperCase() &&
        globalDestinationName.value.toString().toUpperCase() !=
            "amazon".toString().toUpperCase()) {
      return true;
    }
    return true;
  }).toList();
  filteredExperiences = filteredExperiences;
  filteredExperiences = filteredExperiences.where((e) {
    if (e.description == "Leisure Time") {
      return true;
    }
    return getExperienceState(e.description) == "suggested";
  }).toList();
  initializeHours();
  filteredExperiences = filteredExperiences.where((e) {
    // return true;

    if (e.description == "Leisure Time") {
      return true;
    }
    var total = totalHours[currentDay.value] ?? 0.0.obs;
    var acc = accumulatedHours[currentDay.value] ?? 0.0.obs;
    var currentLeft = (total.value - acc.value) * 60;
    var expTime = getExperienceByName(e.description).value["exptime"] ?? 600;
    var rule = expTime <= currentLeft;
    var rule2 =
        (expTime - currentLeft) <= getTrLimit(currentTravelRhythm.value);
    return rule || rule2;
  }).toList();

  filteredExperiences = filteredExperiences.where((e) {
    var closeTime = parseHour(e.value["closeTime"]);
    if (e.description == "Leisure Time") {
      return true;
    }
    if (currentDay.value == 0) {
      if (closeTime - parseHour(arrivalHour.value) >
          getTrLimit(currentTravelRhythm.value)) {
        return true;
      }
      return false;
    } else {
      if (e.value["experience_type"] == "meal") {
        return true;
      }
      endHours[currentDay.value].value =
          time.addHour(totalHours[currentDay.value].value.round() as int);
      var rule = closeTime - toMinutes(endHours[currentDay.value].value) >
          getTrLimit(currentTravelRhythm.value);
      return rule;
    }
  }).toList();

  // filteredExperiences.sort((a, b) {
  //   var aTime = a.value["exptime"];
  //   var bTime = b.value["exptime"];
  //   return aTime.compareTo(bTime);
  // });
  filteredExperiences.sort((a, b) => a.code.compareTo(b.code));
  filteredExperiences.sort((a, b) => a.order.compareTo(b.order));
}

//////////////////////////////////////////////////////////////////////////////////////
getExpFiltered() {
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
}

initializeHours() {
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
}

resetExperiences() {
  for (var exp in globalctx.experiences[currentDay.value] as Iterable) {
    promoteExperience(exp, "suggested");
  }
  resetDayCounters();
}

promoteExperience(String experience, String state) {
  int sign = state == "suggested" ? -1 : 1;
  var value = calculateExperienceDays(experience);
  if (experience == "Leisure Time") {
    value = getFormValue(
        globalctx.memory["days"], currentDay.value, "leisureTime", 0);
  }
  processHour(value * sign);
  setExperienceState(experience, state);
  saveExperience(experience, state);
}

processHour(value) {
  accumulatedHours[currentDay.value].value =
      accumulatedHours[currentDay.value].value + value;
  initializeHours();
}

saveExperience(experience, state) {
  if (state == "promoted") {
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
  }
}

resetDayCounters() {
  accumulatedHours[currentDay.value].value = 0.0;
  leftHours[currentDay.value].value = totalHours[currentDay.value].value;
  initializeHours();
}

setExperienceState(experience, state) {
  globalctx.states["experiences"][currentDay.value] ??= {}.obs;
  globalctx.states["experiences"][currentDay.value][experience] ??= {}.obs;
  globalctx.states["experiences"][currentDay.value][experience]["state"] =
      state;

  filterSuggestedExperiences();
}

getExperienceState(experience) {
  globalctx.states["experiences"][currentDay.value] ??= {}.obs;
  globalctx.states["experiences"][currentDay.value][experience] ??= {}.obs;
  var state =
      globalctx.states["experiences"][currentDay.value][experience]["state"];
  state ??= "suggested";
  return state;
}

var experiencePromotedDragData = Rx(<Widget>[]);

calculateExperienceDays(String experience) {
  var expData = getExperienceByName(experience).value;
  var exptime = (parseInt(expData['exptime']) * 1.0) as double;
  return exptime / 60;
}

getExperienceTravelRhythmByName(String experience) {
  var expData = getExperienceValueByName(experience);
  var trData = findCatalog("travel_rhythm").toList();
  var trObject = trData.firstWhere((e) =>
      e["description"].toString().toUpperCase() ==
      expData["travel_rhythm"].toString().toUpperCase());
  return trObject;
}

getExperienceValueByName(String experience) {
  var result;
  try {
    result = getExperienceByName(experience).value;
  } catch (e) {
    log(e);
  }
  return result;
}

getExperienceByName(String experience) {
  var result;
  try {
    result = toCatalog(expList.firstWhere(
        (element) => element["description"].toString() == experience));
  } catch (e) {
    log(e);
  }
  return result;
}

updateDraggableExperiences() {
  if (globalctx.promotedExperiences.keys.contains("Leisure Time")) {
    destDraggable.value = 0;
  }
}

clearHours() {
  clearedHours[currentDay.value] ??= false;
  if (clearedHours[currentDay.value]) {
    currentTravelRhythm.value = "0";
    totalHours[currentDay.value].value = 10.0;
    leftHours[currentDay.value].value = totalHours[currentDay.value].value -
        accumulatedHours[currentDay.value].value;
  }
}

clearKA() {
  clearedKA[currentDay.value] ??= false;
  if (clearedKA[currentDay.value]) {
    currentDestinationKeyActivities.value = [];
  }
}
