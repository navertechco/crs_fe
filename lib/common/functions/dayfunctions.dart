// Day Functions

// ignore_for_file: prefer_function_declarations_over_variables

import 'package:get/get.dart';
import 'package:naver_crs/pages/5/destination/widgets/destinationdetail/widgets/index.dart';
// ignore: import_of_legacy_library_into_null_safe
import '../index.dart';
import 'functions.dart';

Function paginateDay = (context) async {
  if (globalctx.memory["promoted"] != null &&
      globalctx.memory["promoted"]["day"] != null &&
      globalctx.memory["promoted"]["day"][currentDay.value] != null) {
    await nextDay();
  } else {
    showCustomDialog(
        context, LeftWidget(destination: "quito", index: 0), "Close");
  }
};

Function decideBypass = (direction) {
  int index = getDestinationIndexByDay();
  int explorationMode = int.parse(getFormValue(
      globalctx.memory["destinations"], index, "explorationMode", "0"));
  if (explorationMode > 1) {
    bypassCruise(direction);
  } else {
    bypassSurprise(direction);
  }
};

Function bypassSurprise = (String direction) {
  try {
    int index = getDestinationIndexByDay();
    List keyActivities = (getFormValue(
        globalctx.memory["destinations"], index, "key_activities", []));

    int explorationDay = int.parse(getFormValue(
        globalctx.memory["destinations"], index, "explorationDay", "0"));
    // return;

    if (keyActivities.contains("Surprise")) {
      if (direction == "forward") {
        currentDay.value += explorationDay;
      } else {
        currentDay.value -= explorationDay;
      }
    } else {
      updateCurrentDay(direction);
    }
  } catch (e) {
    log(e);
  }
};

Function bypassCruise = (String direction) {
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
    } else {
      updateCurrentDay(direction);
    }
  } catch (e) {
    log(e);
  }
};

Function adjustCurrentDay = () {
  if (currentDay.value < 0) {
    currentDay.value = 0;
    resetExperiences();
  }
};

Function updateCurrentDay = (direction) {
  if (direction == "forward") {
    currentDay.value += 1;
  } else {
    currentDay.value -= 1;
  }
};

Function jumpDay = (direction) {
  decideBypass(direction);
  expDraggable.value = 1;
  currentDate.value = arrivalDate.value.add(Duration(days: currentDay.value));
  updateCurrentDestination();
  filterSuggestedExperiences();
  initializeHours();
  goto("Experiences");
};

Function jumpDestination = (direction) {
  decideBypass(direction);
  expDraggable.value = 1;
  currentDate.value = arrivalDate.value.add(Duration(days: currentDay.value));
  updateCurrentDestination();
  filterSuggestedExperiences();
  initializeHours();
  goto("Services");
};

Function nextDay = () async {
  if (currentDay.value < totalDays.value - 1) {
    jumpDay("forward");
  } else {
    await prepareDaysToResume();
  }
};

Function nextDestination = () async {
  if (currentDestination.value < globalctx.destinations.length - 1) {
    jumpDestination("forward");
  } else {
    await prepareDaysToResume();
  }
};

Function previousDay = () {
  if (currentDay.value > 0) {
    jumpDay("backward");
  } else {
    resetExperiences();
    goto("Destination");
  }
};

Function previousDestination = () {
  goto("Experience");
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

Function prepareDaysToResume = () async {
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
    globalctx.memory["resume"] = destinations;

    try {
      for (var dest in globalctx.memory["resume"].keys) {
        if (globalctx.memory["resume"][dest] != null)
          globalctx.memory["resume"][dest] =
              globalctx.memory["resume"][dest].value;
      }
    } catch (e) {
      log(e);
    }

    globalctx.payload["tour"] = globalctx.memory["tour"];
    globalctx.payload["logistic"] = globalctx.memory["logistic"];
    globalctx.payload["customer"] = globalctx.memory["customer"];
    globalctx.payload["destinations"] = globalctx.memory["resume"];
    globalctx.payload["days"] = globalctx.memory["days"];
    globalctx.payload["totalDays"] = globalctx.memory["totalDays"];
    globalctx.payload["promoted"] = globalctx.memory["promoted"];

    try {
      for (var day in globalctx.payload["days"].keys) {
        globalctx.payload["days"][day] = globalctx.payload["days"][day].value;
      }
    } catch (e) {
      log(e);
    }

    globalctx.payload["logistic"]["arrival_date"] =
        globalctx.payload["logistic"]["arrival_date"].toString();
    globalctx.payload["logistic"]["since_date"] =
        globalctx.payload["logistic"]["since_date"].toString();
    globalctx.payload["logistic"]["departure_date"] =
        globalctx.payload["logistic"]["departure_date"].toString();
    globalctx.payload["logistic"]["until_date"] =
        globalctx.payload["logistic"]["until_date"].toString();
    await saveTour();
  } catch (e) {
    log(e);
  } finally {
    goto("Services");
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

Function processDaysCatalog = () {
  totalDays.value =
      departureDate.value.difference(arrivalDate.value).inDays + 1;
  if (totalDays.value > 0) {
    daysCatalog.value = [];
    for (int i = 0; i < totalDays.value; i++) {
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

Function parseHour = (str) {
  if (str.contains("h")) {
    var parts = str.split("h");
    return int.parse(parts[0]) * 60 + int.parse(parts[1]);
  } else if (str.contains(":")) {
    var parts = str.split(":");
    return int.parse(parts[0]) * 60 + int.parse(parts[1]);
  } else {
    return int.parse(str);
  }
};
