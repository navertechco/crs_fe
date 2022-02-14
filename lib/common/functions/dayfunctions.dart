// Day Functions

// ignore_for_file: prefer_function_declarations_over_variables

import 'package:get/get.dart';
import 'package:sweetalert/sweetalert.dart';

import '../index.dart';
import 'functions.dart';

Function paginateNextDay = () {
  if (currentDay.value < totalDays.value - 1) {
    nextDay();
  } else {
    prepareDaysToResume();
  }
};

Function nextDay = () {
  currentDay.value++;
  globalDestination.value = processDays()["destination"];
  filterSuggestedExperiences();
};

Function paginateDay = (context) {
  // Get promoted experiences by day and KA
  // var promotedExperiencesByDayAndKA =
  //     getPromotedExperiencesByDayAndKA(currentDay.value);

  //Decide if experiences are 2 almost to paginate
  if (globalctx.memory["promoted"]["day"][currentDay.value] != null) {
    paginateNextDay();
  } else {
    SweetAlert.show(context,
        title: "Promote any experiences is required",
        subtitle: 'error',
        style: SweetAlertStyle.error, onPress: (bool isConfirm) {
      Get.close(1);
      return false;
    });
  }
};

Function getDtos = () {
  var arrival = {"title": "arrival", "explorationDay": "1", "airport": "quito"};
  var departure = {
    "title": "departure",
    "explorationDay": "1",
    "airport": "quito"
  };
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

  return [arrival, departure, day, experience];
};

Function getDestinations = () {
  var dtos = getDtos();
  var arrival = dtos[0];
  var departure = dtos[1];

  Map destinations = {
    "arrival": arrival,
    ...globalctx.memory["destinations"],
    "departure": departure
  };

  return destinations;
};

Function prepareDaysToResume = () {
  List dtos = getDtos();
  Map experience = dtos[3];
  Map dayDto = dtos[2];
  var dayIndex = 0;
  for (String destination in allPromotedDestinations) {
    var destinationDay = globalctx.memory["destinationDay"]
        .firstWhere((e) => e["destination"] == destination);
    var explorationDay = destinationDay["explorationDay"];
    for (var i = 0; i < int.parse(explorationDay); i++) {
      var day = dayDto;
      // Prepare Frame to send to Resume Page
      var exps = globalctx.memory["promoted"]["day"][dayIndex];
      for (var exp in exps.keys) {
        Map newExp = {...experience, ...exps[exp]};
        day["experiences"][exp] = newExp;
      }
      globalctx.memory["destinations"][destination] ??= {};
      globalctx.memory["destinations"][destination]["daysData"] ??= {};
      globalctx.memory["destinations"][destination]["daysData"][dayIndex] = day;
      dayIndex++;
    }
  }
  Get.toNamed("/Resume");
};

Function processDays = () {
  result = [];
  // result.add({"day": 1, "destination": "arrival"});
  var destinationDay = globalctx.memory["destinationDay"];
  var destDays = 0;
  for (var dest in destinationDay) {
    for (var i = 1; i <= dest["days"]; i++) {
      result.add({"day": i, "destination": dest["destination"]});
      destDays++;
    }
  }
  if (result.isNotEmpty) {
    return result[currentDay.value];
  }
  // result.add({"day": destDays + 2, "destination": "departure"});
  return {};
};

Function previousDay = () {
  if (currentDay.value > 0) {
    currentDay.value--;
    globalDestination.value = processDays()["destination"];
    filterSuggestedExperiences();
  } else {
    Get.back();
  }
};
