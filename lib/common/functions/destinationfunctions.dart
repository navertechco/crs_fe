// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sweetalert/sweetalert.dart';
import '../index.dart';
import './functions.dart';

Function promoteDestination = (ctrl, _formKey, destination) {
  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();
    if (!globalctx.promotedDestinations.contains(destination)) {
      globalctx.promotedDestinations.add(destination);
      destinations = globalctx.memory["destinations"];
    }
    // globalDestination.value = destination;
    // filterSuggestedExperiences();
    Get.close(1);
  }
};

// Destination Functions
Function getDestinationAirport = () {
  var airport = "quito";
  try {
    var destinationData = getParam("DESTINATION_DATA")["value"];

    var destinations = globalctx.promotedDestinations;
    var first = destinations[0];
    var last = destinations[destinations.length - 2];
    if (globalDestination.value == "arrival") {
      airport = destinationData[first][5];
    }
    if (globalDestination.value == "departure") {
      airport = destinationData[last][5];
    }
    return airport;
  } catch (e) {
    return airport;
  }
};

Function getFilteredDestination = () {
  globalDestination.value = processDays()["destination"];
  var localDest = globalDestination.value;
  // var airport = getDestinationAirport().toString().toUpperCase();
  var experiences = processCatalog("experiences");
  List filteredByDestination = [];

  for (Map item in experiences) {
    List itemList = item.values.toList();
    CatalogDto experience = CatalogDto(itemList);
    if (experience.value["destination"].toString().toLowerCase() == localDest) {
      filteredByDestination.add(experience);
    }
  }

  List filteredByTravelRhytm = filteredByDestination.where((e) {
    return true;
  }).toList();

  List filteredByDestinationOption = filteredByTravelRhytm.where((e) {
    return true;
  }).toList();

  List filteredByKA = filteredByDestinationOption.where((e) {
    return true;
  }).toList();

  Iterable filteredByAirport = filteredByKA;

  // if (globalDestination.value == "arrival") {
  //   filteredByAirport =
  //       filteredByKA.where((e) => e["title"].contains(airport)).toList();
  // }

  var filteredBySuggested = filteredByAirport.where((e) {
    return getExperienceState(e.description) == "suggested";
  }).toList();

  return filteredBySuggested;
};
Function checkPromotedAirport = (destination) {
  bool quitoPromoted = globalctx.promotedDestinations.contains("quito");
  bool gyePromoted = globalctx.promotedDestinations.contains("guayaquil");
  if (destination != "quito" && destination != "guayaquil") {
    return (quitoPromoted || gyePromoted);
  }

  return true;
};

Function getCombinedDestinations = () {
  var departure = {
    "explorationDay": "1",
    "days": "1",
    "airport": "quito",
    "daysData": {}
  };
  var memoryDestinations = {};
  for (var destination in destinations.entries) {
    var key = destination.key;
    var value = destination.value;
    memoryDestinations = {...memoryDestinations, key: value};
  }
  destinations = memoryDestinations;
  var result = {
    // "arrival": arrival,
    ...memoryDestinations,
    "departure": departure
  };

  return result;
};

Function processDestinations = (context) {
  // ignore: unrelated_type_equality_checks
  if (globalctx.promotedDestinations.isNotEmpty & (dayleft == 0)) {
    globalDestination.value = globalctx.promotedDestinations[0];

    var destinationDay = [];
    // var arrival = {"explorationDay": "1", "days": "1", "airport": "quito"};

    for (var i = 0; i < totalDays.value; i++) {
      globalctx.experienceDragData.value[i] ??= <Widget>[];
      // globalctx.promotedExperiences[i] ??= [].obs;
    }

    var destinations = getCombinedDestinations();

    for (var destination in allPromotedDestinations) {
      var dest = destinations[destination];
      var explorationDays = dest["explorationDay"];
      var days = int.parse(explorationDays);
      destinationDay.add({...dest, "destination": destination, "days": days});
      destDays.value += days;
    }
    // totalDays.value = destDays;
    globalctx.memory["destinationDay"] = destinationDay;
    globalctx.memory["totalDays"] = totalDays.value;
    selectedIndex++;
    Get.toNamed("/Experiences");
  } else {
    if (context != null) {
      SweetAlert.show(context,
          curve: ElasticInCurve(),
          title: (dayleft.value > 0)
              ? "Days Left can't be greater than 0\n"
              : "Promote any destination is required",
          style: SweetAlertStyle.error, onPress: (bool isConfirm) {
        Get.close(1);
        return false;
      });
    }
  }
};
Function findDestination = (destination) {
  var promotedDestinations = globalctx.promotedDestinations;
  var result = "departure";
  var index =
      promotedDestinations.indexWhere((element) => element == destination);
  if (index == -1) {
    if (destination == "arrival") {
      result = "arrival";
    }
  } else {
    result = promotedDestinations[index];
  }
  return result;
};
