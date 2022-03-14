// Day Functions

// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/pages/5/destination/widgets/destinationdetail/widgets/index.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sweetalert/sweetalert.dart';
import '../index.dart';
import 'functions.dart';
import 'tourfunctions.dart';

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
  if (currentDay.value < destDays.value - 1) {
    nextDay();
  } else {
    prepareDaysToResume();
  }
};

Function nextDay = () {
  currentDay.value++;
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
  // print(globalctx.memory);
  // sendTour(globalctx.memory);
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

Function previousDay = () {
  if (currentDay.value > 0) {
    currentDay.value--;
    processDays();
    filterSuggestedExperiences();
  } else {
    dayleft.value = 0;
    selectedIndex.value = selectedIndex.value - 1;
    Get.back();
  }
};
