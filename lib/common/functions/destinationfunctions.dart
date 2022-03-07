// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/pages/5/destination/widgets/index.dart';
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
    // var destinationData = getParam("DESTINATION_DATA")["value"];

    // var destinations = globalctx.promotedDestinations;
    // var first = destinations[0];
    // var last = destinations[destinations.length - 2];
    // if (globalDestination.value == "arrival") {
    //   airport = destinationData[first][5];
    // }
    // if (globalDestination.value == "departure") {
    //   airport = destinationData[last][5];
    // }
    return airport;
  } catch (e) {
    return airport;
  }
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
    // "departure": departure
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
              ? "You still have $dayleft days to enjoy, do you want to review the other options we have for you?"
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
  // var result = "departure";
  var index =
      promotedDestinations.indexWhere((element) => element == destination);
  // if (index == -1) {
  //   if (destination == "arrival") {
  //     result = "arrival";
  //   }
  // } else {
  var result = promotedDestinations[index];
  // }
  return result;
};

Function addDestination = (String destination) {
  if (!globalctx.destinations.contains(destination)) {
    globalctx.destinations.add(destination);
  }
};

Function filterSelectedDestinations = () {
  var selectedDestinations = globalctx.destinations;
  var allDestinations = processCatalog("destinations");
  var arrival = allDestinations
      .toList()
      .where((element) => element["code"] == int.parse(arrivalPort.value))
      .first;
  var departure = allDestinations
      .toList()
      .where((element) => element["code"] == int.parse(departurePort.value))
      .first;
  if (selectedDestinations.contains(arrival["description"])) {
    selectedDestinations.remove(arrival["description"]);
  }
  if (selectedDestinations.contains(departure["description"])) {
    selectedDestinations.remove(departure["description"]);
  }
  selectedDestinations.insert(0, arrival["description"]);
  selectedDestinations.add(departure["description"]);
  globalctx.selectedDestinations.value = [];
  globalctx.destinationDragData.value = <Widget>[];

  for (var selected in selectedDestinations) {
    moveDestination(selected);
  }
};

Function moveDestination = (String destination) {
  // var checked = checkPromotedAirport(destination);
  // if ( !globalctx.selectedDestinations.contains(destination) &&
  //     dayleft.value != 0 &&
  //     checked) {
  // globalctx.destinations.add(destination);
  setDestinationState(destination, "selected");
  globalctx.selectedDestinations.add(destination);
  globalctx.destinationDragData.value
      .add(DragDestinationWidget(destination: destination));
  // }
  // if (!filteredYet) {
  //   filterSelectedDestinations();
  // }
};

Function getDestinationId = (String destination) {
  var allDestinations = processCatalog("destinations");
  var id = allDestinations
      .toList()
      .where((element) => element["description"] == destination)
      .first;
  return id["code"].toString();
};

Function getDestinationValue = (String destination) {
  var allDestinations = processCatalog("destinations");
  var result = allDestinations
        .firstWhere((e) => e["description"] == destination)["value"];
  return result;
};

Function setDestinationState = (destination, state) {
  globalctx.states["destinations"][destination] ??= {}.obs;
  globalctx.states["destinations"][destination]["state"] = state;
};

Function getDestinationState = (destination) {
  globalctx.states["destinations"][destination] ??= {}.obs;
  var state = globalctx.states["destinations"][destination]["state"];
  state ??= "suggested";
  return state;
};
