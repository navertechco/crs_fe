// Day Functions

// ignore_for_file: prefer_function_declarations_over_variables

import 'package:get/get.dart';
import 'package:naver_crs/pages/5/destination/widgets/destinationdetail/widgets/index.dart';
// ignore: import_of_legacy_library_into_null_safe
import '../index.dart';
import 'functions.dart';

Function paginateDay = (context) {
  // Get promoted experiences by day and KA
  // var promotedExperiencesByDayAndKA =
  //     getPromotedExperiencesByDayAndKA(currentDay.value);

  //Decide if experiences are 2 almost to paginate
  if (globalctx.memory["promoted"] != null &&
      globalctx.memory["promoted"]["day"] != null &&
      globalctx.memory["promoted"]["day"][currentDay.value] != null) {
    paginateNextDay();
  } else {
    showCustomDialog(
        context, LeftWidget(destination: "quito", index: 0), "Close");
  }
};
Function paginateNextDay = () {
  if (currentDay.value < totalDays.value - 1) {
    byPassCruise("forward");
    nextDay();
  } else {
    prepareDaysToResume();
  }
};

Function byPassCruise = (String direction) {
  try {
    int index = getDestinationIndex(globalDestinationName.value, "tour");
    int explorationMode = int.parse(getFormValue(
        globalctx.memory["destinations"], index, "explorationMode", "0"));
    int explorationDay = 0;
    int cruiseExpDays = int.parse(getFormValue(
        globalctx.memory["destinations"], index, "cruiseExpDays", "0"));
    if (cruiseExpDays > 0) {
      if (explorationMode > 1) {
        DateTime cruiseStartDate = getFormValue(
            globalctx.memory["destinations"],
            index,
            "cruiseStartDate",
            DateTime(5555, 02, 02));
        DateTime cruiseEndDate = getFormValue(globalctx.memory["destinations"],
            index, "cruiseEndDate", DateTime(5555, 02, 02));

        if (direction == "forward") {
          if (currentDate.value ==
              cruiseStartDate.subtract(Duration(days: 1))) {
            explorationDay = cruiseExpDays;
            currentDay.value += explorationDay;
          }
        } else {
          if (currentDate.value == cruiseEndDate.add(Duration(days: 1))) {
            explorationDay = cruiseExpDays;
            currentDay.value -= explorationDay;
          }
        }
      }
    }
  } catch (e) {
    log(e);
  }
};

Function nextDay = () {
  expDraggable.value = 1;
  currentDay.value++;
  currentDate.value = arrivalDate.value.add(Duration(days: currentDay.value));
  updateCurrentDestination();
  filterSuggestedExperiences();
  initializeHours();
};

Function getDtos = () {
  var day = {
    "date": "",
    "observation": "",
    "day_description": "",
    "day_name": "",
    "parent": 0,
    "option_id": 1,
    "transport_id": 1,
    "key_activities": [],
    "meals": "B/L/D/O",
    "experiences": {},
    "destination": ""
  };

  var experience = {
    "destination": "",
    "day": "",
    "title": "",
    "description": "",
    "next": "",
    "previous": "",
    "experience_id": "",
    "photo": ""
  };

  return [day, experience];
};

Function prepareDaysToResume = () {
  try {
    var dayIndex = 0;
    var destinations = getCombinedDestinations();
    for (String dest in destinations.keys.toList()) {
      var destination = destinations[dest];
      destination["daysData"] ??= {};
      destination["daysData"] = {};
      destinations[dest] = destination;
      var explorationDay = destination["explorationDay"];

      for (var i = 0; i < int.parse(explorationDay); i++) {
        var dayDto = getDtos()[0];
        var expDto = getDtos()[1];
        // Prepare Frame to send to Resume Page
        var exps = globalctx.memory["promoted"]["day"][dayIndex];
        for (var exp in exps.keys) {
          Map newExp = {};
          Map newEntry = exps[exp];
          newExp = {...expDto, ...newEntry};
          dayDto["experiences"][exp] = newExp;
        }
        destinations[dest]["daysData"][dayIndex] = dayDto;
        dayIndex++;
      }
    }
  } catch (e) {
    log(e);
  } finally {
    log(globalctx.memory);
    // sendTour(globalctx.memory);
    goto("EndServices");
  }
};

Function processDays = () {
  result = [];

  for (String dest in destinations.keys.toList()) {
    for (int i = 1; i <= int.parse(destinations[dest]["explorationDay"]); i++) {
      result.add({"day": i, "destination": destinations[dest]["destination"]});
    }
  }

  if (result.isNotEmpty) {
    globalDestinationName.value = result[currentDay.value]["destination"];
    clearedHours[currentDay.value] ??= false;
    clearedKA[currentDay.value] ??= false;
    if (!clearedHours[currentDay.value]) {
      updateCurrentDestinationTravelRhythm();
    }
    if (!clearedKA[currentDay.value]) {
      updateCurrentKeyActivities();
    }
  }
};
Function updateCurrentKeyActivities = () {
  var index = getDestinationIndexByDay();
  var ka = getFormValue(
      globalctx.memory["destinations"], index, "key_activities", []);
  currentDestinationKeyActivities.value = ka;
};

Function updateCurrentDestinationOption = () {
  var index = getDestinationIndexByDay();
  var destinationOption = getFormValue(
      globalctx.memory["destinations"], index, "destination_option", "1");
  currentDestinationOption.value = destinationOption;
};
Function updateCurrentDestinationTravelRhythm = () {
  var index = getDestinationIndexByDay();
  var travelRhythm = getFormValue(
      globalctx.memory["destinations"], index, "travel_rhythm", "1");
  currentTravelRhythm.value = travelRhythm;
};

Function previousDay = () {
  if (currentDay.value > 0) {
    byPassCruise("backward");
    currentDay.value--;
    currentDate.value = arrivalDate.value.add(Duration(days: currentDay.value));
    updateCurrentDestination();
    processDays();
    filterSuggestedExperiences();
  } else {
    goto("Destination");
  }
};
Function processDaysCatalog = () {
  int total = departureDate.value.difference(arrivalDate.value).inDays;
  if (total > 0) {
    daysCatalog.value = [];
    for (int i = 0; i < total; i++) {
      Map<String, dynamic> row = {};
      row["code"] = i + 1;
      row["description"] = "Day ${i + 1}";
      daysCatalog.add(row);
    }
  }
};
Function resetLeftDays = () {
  leftAccumulated.value = 0;
  dayleft.value = totalDays.value;
  accumulated.value = 0;
};
Function saveExplorationDays = (int index, int val0, int val1, {String? key}) {
  try {
    int acc0 = accumulated.value;
    int td = totalDays.value;
    int total0 = int.parse(getFormValue(
        globalctx.memory["destinations"], index, "explorationDay", "0"));
    int nei0 = total0 - val0;
    if (total0 == 0 || nei0 < 0) {
      nei0 = 0;
    }

    if (acc0 < td) {
      int nei1 = nei0;
      int total1 = nei1 + val1;
      int acc1 = total1 - nei0 - val0 + acc0;
      int dl1 = td - acc1;

      dayleft.value = dl1;
      accumulated.value = acc1;
      if (key != null) {
        setFormValue(
            globalctx.memory["destinations"], index, key, val1.toString());
      }

      setFormValue(globalctx.memory["destinations"], index, "explorationDay",
          (total1).toString());
      if (index == 0) {
        firstDayDate = Rx(arrivalDate.value.add(Duration(days: acc1)));
      }
    }
  } catch (e) {
    log(e);
  }
};
