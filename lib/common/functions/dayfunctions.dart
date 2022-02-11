// Day Functions

// ignore_for_file: prefer_function_declarations_over_variables

import 'package:get/get.dart';
import 'package:sweetalert/sweetalert.dart';

import '../index.dart';
import 'functions.dart';

Function paginateNextDay = () {
  // Paginate to Next Day
  if (currentDay.value < totalDays.value) {
    currentDay.value += 1;
    destination.value = processDays()["destination"];
    filterSuggestedExperiences();
  } else {
    prepareDaysToResume();
  }
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

Function prepareDaysToResume = () {
  var arrival = {"title": "arrival", "explorationDay": "1", "airport": "quito"};
  var departure = {
    "title": "departure",
    "explorationDay": "1",
    "airport": "quito"
  };

  var destinations = {
    "arrival": arrival,
    ...globalctx.memory["destinations"],
    "departure": departure
  };
  var destinationindex = 0;
  for (var destination in allPromotedDestinations) {
    var dest = destinations[destination];
    var explorationDay = dest["explorationDay"];
    var actualDay = 0;
    for (var i = 0; i < int.parse(explorationDay); i++) {
      // Prepare Frame to send to Resume Page
      var day = {
        "date": "",
        "observation": "",
        "day_description": "",
        "day_name": "",
        "parent": 0,
        "option_id": 1,
        "transport_id": 1,
        "key_activities": [],
        "meals": [],
        "experiences": {},
        "destination": dest
      };

      var experience = {
        "destination": dest,
        "day": "",
        "title": "",
        "description": "",
        "next": "",
        "previous": "",
        "experience_id": "",
        "photo": ""
      };
      var exps = globalctx.memory["promoted"]["day"][i];

      for (var exp in exps.keys) {
        var newExp = {...experience, ...exps[exp]};
        day["experiences"][exp] = newExp;
      }

      globalctx.memory["days"][actualDay] ??= {};
      globalctx.memory["days"][actualDay] = day;
      globalctx.memory["destinations"][destination] ??= {};
      globalctx.memory["destinations"][destination]["days"] = {};
      globalctx.memory["destinations"][destination]["days"][actualDay] = day;
      globalctx.memory['destinationDay'][destinationindex] ??= {};
      globalctx.memory['destinationDay'][destinationindex]['days'] = {};
      globalctx.memory['destinationDay'][destinationindex]['days'][actualDay] =
          day;
      actualDay = destination == "arrival" ? 0 : actualDay + 1;
    }
    destinationindex++;
  }
  Get.toNamed("/Resume");
};

Function processDays = () {
  result = [];
  result.add({"day": 1, "destination": "arrival"});
  var destinations = globalctx.memory["destinationDay"];
  for (var dest in destinations) {
    for (var i = 2; i <= dest["days"]; i++) {
      result.add({"day": i, "destination": dest["destination"]});
    }
  }
  result.add({"day": destinations.length, "destination": "departure"});
  return result[currentDay.value];
};

Function previousDay = () {
  if (currentDay.value > 0) {
    currentDay.value -= 1;
    destination.value = processDays()["destination"];
    filterSuggestedExperiences();
  } else {
    Get.back();
  }
};
