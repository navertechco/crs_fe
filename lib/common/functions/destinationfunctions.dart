// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sweetalert/sweetalert.dart';
import '../index.dart';
import './functions.dart';

// Destination Functions
Function getDestinationAirport = (destination) {
  var airport = "quito";
  try {
    var destinationData = getParam("DESTINATION_DATA")["value"];
    var destinations = globalctx.promotedDestinations;
    var first = destinations[0];
    var last = destinations[destinations.length - 2];
    if (destination == "arrival") {
      airport = destinationData[first][5];
    }
    if (destination == "departure") {
      airport = destinationData[last][5];
    }
    return airport;
  } catch (e) {
    return airport;
  }
};

Function getFilteredDestination = (dest) {
  var airport = getDestinationAirport(dest).toString().toUpperCase();

  List filteredByDestination = experiences
          .where((e) => e["destination"]
              .toString()
              .toUpperCase()
              .contains(dest.toUpperCase()))
          .toList() ??
      [];

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

  if (dest == "arrival") {
    filteredByAirport =
        filteredByKA.where((e) => e["title"].contains(airport)).toList();
  }

  var filteredBySuggested = filteredByAirport.where((e) {
    return getExperienceState(e["title"]) == "suggested";
  }).toList();

  return filteredBySuggested;
};

Function processDestinations = (dayleft, context) {
  if (globalctx.promotedDestinations.isNotEmpty & (dayleft.value == 0)) {
    var destinationDay = [];
    var arrival = {"explorationDay": "1", "airport": "quito"};
    var departure = {"explorationDay": "1", "airport": "quito"};

    var destinations = {
      "arrival": arrival,
      ...globalctx.memory["destinations"],
      "departure": departure
    };

    for (var i = 0; i < totalDays.value; i++) {
      globalctx.experienceDragData.value[i] ??= <Widget>[];
      // globalctx.promotedExperiences[i] ??= [].obs;
    }

    for (var destination in allPromotedDestinations) {
      var dest = destinations[destination];
      var explorationDays = dest["explorationDay"];
      var days = int.parse(explorationDays);
      destinationDay.add({...dest, "destination": destination, "days": days});
      // totalDays.value += days;
    }
    globalctx.memory["destinationDay"] = destinationDay;
    globalctx.memory["totalDays"] = totalDays;
    Get.toNamed("/Experiences");
  } else {
    SweetAlert.show(context,
        title: (dayleft.value > 0)
            ? "Days Left can't be greater than 0\n"
            : "" + "Promote any destination is required",
        subtitle: 'error',
        style: SweetAlertStyle.error, onPress: (bool isConfirm) {
      Get.close(1);
      return false;
    });
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
