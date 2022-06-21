import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../index.dart';

var allPromotedDestinations = globalctx.promotedDestinations;
var globalDestinationName = Rx("quito");
var globalDestinationType = Rx("arrival");
var globalDestinationIndex = Rx("0");
var allDestinations = memory["destinations"];
var destinationList = allDestinations.entries
    .map((e) => {"destination": e.key.toString(), ...e.value})
    .toList();
List<dynamic> customDestinationData = [
  ...destinationList,
];
var promotedDestinations = globalctx.promotedDestinations;
RxString destCountry = "1".obs;
var selectedDestinations = globalctx.destinations;
var destinationsCatalog = findCatalog("destinations");
var destinationCountry = findCatalog("destination_country");
var currentDestinationTr =
    getDestinationTravelRhythm(globalDestinationName.value, "arrival");
var currentDestinationTrRange = currentDestinationTr["value"];
var currentDestinationTrMinRange = Rx(currentDestinationTrRange["min"]);
var currentDestinationTrMaxRange = Rx(currentDestinationTrRange["max"]);
var currentDestinationType = "arrival";
var currentDestinationKeyActivities = [].obs;
var currentDestinationOption = "0".obs;
RxString arrivalState =
    getDestinationState(arrival["description"], 0, "arrival").toString().obs;
RxString departureState = getDestinationState(
        departure["description"], destinations.length - 1, "departure")
    .toString()
    .obs;
var detsdata = getValue(memory, "destinations", def: []);
RxInt destDraggable = 0.obs;
var destDays = [];
List destList = getParam("DESTINATION_DATA").values.toList();
CatalogDto destinationData = CatalogDto(destList);
Map<dynamic, dynamic> destinations = globalctx.memory["destinations"] ?? {};
RxList<Widget> destlist = <Widget>[].obs;
Rx<String> arrivalHour = Rx(getFormValue(
    globalctx.memory["destinations"], 0, "arrival_value", "00:00"));
Rx<int> guide = Rx(getFormValue(globalctx.memory["destinations"],
    globalDestinationIndex.value, "guide_type", 1));
var currentDestinationIndex = 0.obs;
