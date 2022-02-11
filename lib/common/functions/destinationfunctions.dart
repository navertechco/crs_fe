// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter/material.dart';

import '../index.dart';
import './functions.dart'; 

// Destination Functions

Function getDestinationAirport = (destination) {
  var airport = "quito";
  try {
    var destinationData = getParam("DESTINATION_DATA")["value"];
    var destinations = globalctx.promotedDestinations.value;
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

Function getFiltered = (dest) {
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



Function processDestinations = () {
  var destinationDay = [];
  var arrival = {"explorationDay": "1", "airport": "quito"};
  var departure = {"explorationDay": "1", "airport": "quito"};

  var destinations = {
    "arrival": arrival,
    ...globalctx.memory.value["destinations"],
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
};
