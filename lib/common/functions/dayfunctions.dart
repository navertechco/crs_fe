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
    nextDay();
  } else {
    prepareDaysToResume();
  }
};

Function nextDay = () {
  currentDay.value++;
  updateDestinationType();
  processDays();
  filterSuggestedExperiences();
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
  // log(globalctx.memory);
  // sendTour(globalctx.memory);
  selectedIndex.value = pageList.indexOf("Resume");
  Get.toNamed("/Resume");
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
  }
};

Function updateCurrentDestinationTravelRhythm = () {
  var index = getDestinationIndex(
      globalDestinationName.value, globalDestinationType.value);
  var travelRhythm = (getFormValue(
      globalctx.memory["destinations"], index, "travelRhythm", "1"));
  currentTravelRhythm.value = travelRhythm;
};

Function previousDay = () {
  if (currentDay.value > 0) {
    currentDay.value--;
    updateDestinationType();
    processDays();
  } else {
    dayleft.value = 0;
    selectedIndex.value = pageList.indexOf("Destination");
    Get.toNamed("/Destination");
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
Function resetDays = () {
  totalDays.value = departureDate.value.difference(arrivalDate.value).inDays;
  leftAccumulated.value = 0;
  dayleft.value = totalDays.value;
  accumulated.value = 0;
};
Function saveExplorationDays = (int index, int init0, int value) {
  try {
    int acc0 = accumulated.value;
    int td1 = totalDays.value;

    if (acc0 < td1) {
      int val1 = value - init0;
      // int init1 = init0 + val1;
      int acc1 = acc0 + val1;
      int dl1 = td1 - acc1;

      dayleft.value = dl1;
      accumulated.value = acc1;
      setFormValue(globalctx.memory["destinations"], index, "explorationDay",
          value.toString());
    }
  } catch (e) {
    log(e);
  }
};
