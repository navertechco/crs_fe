// Experience functions
// ignore_for_file: prefer_function_declarations_over_variables
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl/intl.dart';
import 'package:naver_crs/pages/6/experiences/widgets/custom/index.dart';
import 'package:naver_crs/index.dart';

// ███████╗██╗  ██╗██████╗ ███████╗██████╗ ██╗███████╗███╗   ██╗ ██████╗███████╗
// ██╔════╝╚██╗██╔╝██╔══██╗██╔════╝██╔══██╗██║██╔════╝████╗  ██║██╔════╝██╔════╝
// █████╗   ╚███╔╝ ██████╔╝█████╗  ██████╔╝██║█████╗  ██╔██╗ ██║██║     █████╗
// ██╔══╝   ██╔██╗ ██╔═══╝ ██╔══╝  ██╔══██╗██║██╔══╝  ██║╚██╗██║██║     ██╔══╝
// ███████╗██╔╝ ██╗██║     ███████╗██║  ██║██║███████╗██║ ╚████║╚██████╗███████╗
// ╚══════╝╚═╝  ╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝╚══════╝╚═╝  ╚═══╝ ╚═════╝╚══════╝

// ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗
// ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
// █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗
// ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║
// ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║
// ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝

/// ## filterSuggestedExperiences
/// *__Method to filter and reorder suggested experiences__*
///
///### Uses:
/// ```dart
///    filterSuggestedExperiences();
/// ```
/// ### Returns:
///```dart
/// void
///```
void filterSuggestedExperiences() {
  processDays();
  filterExperiences();
  clearCurrentDayHours();
  clearCurrentDestinationKeyActivities();
}

/// ## filterExperiences
/// *__Method to filter experiences__*
///
///### Uses:
/// ```dart
///    filterExperiences();
/// ```
/// ### Returns:
///```dart
/// void
///```
void filterExperiences() {
  processFilteredExperienes();
  updateSelectedDragExperiences();
}

/// ## updateSelectedDragExperiences
/// *__Method to update experience drag objects__*
///
///### Uses:
/// ```dart
///    updateSelectedDragExperiences();
/// ```
/// ### Returns:
///```dart
/// void
///```
updateSelectedDragExperiences() {
  experienceSelectedDragData.value = <Widget>[];
  var expGroups = {};

  for (var experience in filteredExperiences) {
    if (!expGroups.keys.contains(experience.value["experience_type"])) {
      expGroups[experience.value["experience_type"]] = <Widget>[];
      expGroups[experience.value["experience_type"]].add(CustomTitleWidget(
          fontWeight: FontWeight.bold,
          label:
              experience.value["experience_type"].toString().capitalizeFirst!,
          color: Colors.white));
    }
    expGroups[experience.value["experience_type"]]
        .add(DragableExperience(experience: experience, suggested: true));
  }

  for (List<Widget> group in expGroups.values) {
    experienceSelectedDragData.value.addAll(group);
  }
}

/// ## getFilteredExperiences
/// *__Method to get filtered experiences__*
///
///### Uses:
/// ```dart
///    processFilteredExperienes();
/// ```
/// ### Returns:
///```dart
/// void
///```
void processFilteredExperienes() {
  filteredExperiences = getExpFilteredByDestination();
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
      var tr = getExperienceDataByName(e.description).value["experience_type"];
      var rule = tr == compare;
      return rule;
    } catch (e) {
      return true;
    }
    // return rule;
  }).toList();
  filteredExperiences = filteredExperiences.where((e) {
    if (currentDestinationKeyActivities.isEmpty) {
      return true;
    }
    if (currentDay.value == 0 || e.description == "Leisure Time") {
      return true;
    }

    var destKa = getDestinationKa(
        globalDestinationName.value, globalDestinationType.value);
    String ka1 = getExperienceDataByName(e.description)
        .value["keyActivityType_fk"]
        .toString();
    String ka2 = getExperienceDataByName(e.description)
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
    String p1 = getExperienceDataByName(e.description).value["purpose_fk"];
    String p2 = getExperienceDataByName(e.description).value["purpose_fk2"];
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
      var open = getExperienceDataByName(e.description)
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
    var expTime =
        getExperienceDataByName(e.description).value["exptime"] ?? 600;
    var rule = expTime <= currentLeft;
    var rule2 = (expTime - currentLeft) <=
        getTravekRhythmLimit(currentTravelRhythm.value);
    return rule || rule2;
  }).toList();

  filteredExperiences = filteredExperiences.where((e) {
    var closeTime = parseHour(e.value["closeTime"]);
    if (e.description == "Leisure Time") {
      return true;
    }
    if (currentDay.value == 0) {
      if (closeTime - parseHour(arrivalHour.value) >
          getTravekRhythmLimit(currentTravelRhythm.value)) {
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
          getTravekRhythmLimit(currentTravelRhythm.value);
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

/// ## getExpFilteredByDestination
/// *__Method to get filtered experiences by destination__*
///
///### Uses:
/// ```dart
///    getExpFilteredByDestination();
/// ```
/// ### Returns:
///```dart
/// List
///```
List getExpFilteredByDestination() {
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

/// ## initializeHours
/// *__Method to initialize hourd__*
///
///### Uses:
/// ```dart
///    initializeHours();
/// ```
/// ### Returns:
///```dart
/// void
///```
void initializeHours() {
  leftHours[currentDay.value] ??= 0.0.obs;
  accumulatedHours[currentDay.value] ??= 0.0.obs;
  totalHours[currentDay.value] ??= 0.0.obs;
  endHours[currentDay.value] ??= time.obs;
  totalHours[currentDay.value].value = getMaxTrValue(currentTravelRhythm.value);
  leftHours[currentDay.value].value = totalHours[currentDay.value].value -
      accumulatedHours[currentDay.value].value;
  endHours[currentDay.value].value =
      time.addHour(totalHours[currentDay.value].value.round() as int);
  clearCurrentDayHours();
  clearCurrentDestinationKeyActivities();
}

/// ## promoteMealExperiences
/// *__Method to update Meals Experiences__*
///
///### Uses:
/// ```dart
///    promoteMealExperiences();
/// ```
/// ### Returns:
///```dart
/// void
///```
void promoteMealExperiences() {
  try {
    if (globalctx.experiences.isNotEmpty &&
        globalctx.experiences[currentDay.value] != null) {
      for (var exp in globalctx.experiences[currentDay.value] as Iterable) {
        var expData = getExperienceValueByName(exp);
        if (expData["experience_type"] == "meal") {
          promoteExperience(exp, "promoted");
        }
      }
    }
  } catch (e) {
    log(e);
  }
}

/// ## resetExperiences
/// *__Method to reset Experiences__*
///
///### Uses:
/// ```dart
///    resetExperiences();
/// ```
/// ### Returns:
///```dart
/// void
///```
void resetExperiences() {
  for (var exp in globalctx.experiences[currentDay.value] as Iterable) {
    promoteExperience(exp, "suggested");
  }
  resetDayCounters();
}

/// ## promoteExperience
/// *__Method to promote Experiences__*
///
///### Uses:
/// ```dart
///      promoteExperience("Leisure Time", "promoted");
/// ```
/// ### Returns:
///```dart
/// void
///```
void promoteExperience(String experience, String state) {
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

/// ## processHour
/// *__Method to discount or add prooted experience hour__*
///
///### Uses:
/// ```dart
///        processHour(value * sign);
/// ```
/// ### Returns:
///```dart
/// void
///```
void processHour(value) {
  accumulatedHours[currentDay.value].value =
      accumulatedHours[currentDay.value].value + value;
  initializeHours();
}

/// ## saveExperience
/// *__Method to save experience__*
///
///### Uses:
/// ```dart
///        saveExperience(experience, state);
/// ```
/// ### Returns:
///```dart
/// void
///```
void saveExperience(experience, state) {
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
    globalctx.memory["promoted"] ??= {};
    globalctx.memory["promoted"][currentDay.value] ??= {};
    globalctx.memory["promoted"][currentDay.value][experience] =
        experienceData.toJson();
  }
}

/// ## resetDayCounters
/// *__Method to reset day counters__*
///
///### Uses:
/// ```dart
///        resetDayCounters();
/// ```
/// ### Returns:
///```dart
/// void
///```
void resetDayCounters() {
  accumulatedHours[currentDay.value].value = 0.0;
  leftHours[currentDay.value].value = totalHours[currentDay.value].value;
  initializeHours();
}

/// ## setExperienceState
/// *__Method to set Experience State__*
///
///### Uses:
/// ```dart
///       setExperienceState(experience, state);
/// ```
/// ### Returns:
///```dart
/// void
///```
void setExperienceState(experience, state) {
  globalctx.states["experiences"][currentDay.value] ??= {}.obs;
  globalctx.states["experiences"][currentDay.value][experience] ??= {}.obs;
  globalctx.states["experiences"][currentDay.value][experience]["state"] =
      state;

  filterSuggestedExperiences();
}

/// ## getExperienceState
/// *__Method to get Experience State__*
///
///### Uses:
/// ```dart
///     suggested = getExperienceState(experience) == "suggested";
/// ```
/// ### Returns:
///```dart
/// String
///```
String getExperienceState(experience) {
  globalctx.states["experiences"][currentDay.value] ??= {}.obs;
  globalctx.states["experiences"][currentDay.value][experience] ??= {}.obs;
  var state =
      globalctx.states["experiences"][currentDay.value][experience]["state"];
  state ??= "suggested";
  var expData = getExperienceValueByName(experience);
  if (expData["experience_type"] == "meal") {
    return "promoted";
  }
  return state;
}

/// ## calculateExperienceDays
/// *__Method to calculate Experience Days__*
///
///### Uses:
/// ```dart
///     var value = calculateExperienceDays(experience);
/// ```
/// ### Returns:
///```dart
/// double
///```
double calculateExperienceDays(String experience) {
  var expData = getExperienceDataByName(experience).value;
  double exptime = (parseInt(expData['exptime']) * 1.0);
  return exptime / 60;
}

/// ## getExperienceValueByName
/// *__Method to Experience Value by Name__*
///
///### Uses:
/// ```dart
///     var expData = getExperienceValueByName(experience);
/// ```
/// ### Returns:
///```dart
/// double
///```
getExperienceValueByName(String experience) {
  var result;
  try {
    result = getExperienceDataByName(experience).value;
  } catch (e) {
    log(e);
  }
  return result;
}

/// ## getExperienceDataByName
/// *__Method to Experience Data by Name__*
///
///### Uses:
/// ```dart
///     var expData = getExperienceDataByName(experience);
/// ```
/// ### Returns:
///```dart
/// dynamic
///```
dynamic getExperienceDataByName(String experience) {
  var expCatalog = findCatalog("experiences").toList();
  var result;
  try {
    result = toCatalog(expCatalog.firstWhere(
        (element) => element["description"].toString() == experience));
  } catch (e) {
    log(e);
  }
  return result;
}

/// ## setCurrentLeisureTime
/// *__Method set the current Leisure time of Day__*
///
///### Uses:
/// ```dart
///     setCurrentLeisureTime(lt.value);
/// ```
/// ### Returns:
///```dart
/// void
///```
void setCurrentLeisureTime(value) {
  int ltindex =
      expList.indexWhere((element) => element["description"] == "Leisure Time");
  globalctx.context.value["catalogs"]["experiences"][ltindex]["value"]
          ["exptime"] ==
      value;
  experiences = findCatalog("experiences");
}

/// ## clearCurrentDayHours
/// *__Method to clear Hours__*
///
///### Uses:
/// ```dart
///     clearCurrentDayHours();
/// ```
/// ### Returns:
///```dart
/// void
///```
void clearCurrentDayHours() {
  clearedHours[currentDay.value] ??= false;
  if (clearedHours[currentDay.value]) {
    currentTravelRhythm.value = "0";
    totalHours[currentDay.value].value = 10.0;
    leftHours[currentDay.value].value = totalHours[currentDay.value].value -
        accumulatedHours[currentDay.value].value;
  }
}
