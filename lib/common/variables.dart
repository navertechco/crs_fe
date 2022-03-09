// ignore_for_file: prefer_function_declarations_over_variables
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import './constants.dart';
import 'index.dart';

////
Rx<int> leftAccumulated = 0.obs;
var airports = {"1": "quito", "2": "guayaquil"};
Rx<int> currentDay = 0.obs;
var result = [];
var allPromotedDestinations = globalctx.promotedDestinations.value;
var globalDestination = Rx("");

RxInt destDays = 0.obs;
List destList = getParam("DESTINATION_DATA").values.toList();
CatalogDto destinationData = CatalogDto(destList);
Map<dynamic, dynamic> destinations = globalctx.memory["destinations"] ?? {};
Rx<DateTime> birthDate =
    Rx(DateTime.parse(globalctx.memory["customer"]["birth_date"]));
Rx<DateTime> arrivalDate = Rx(DateTime.now());
Rx<DateTime> departureDate = Rx(DateTime.now());
Rx<DateTime> sinceDate = Rx(DateTime.now());
Rx<DateTime> untilDate = Rx(DateTime.now());
RxList<String> ocDays = <String>[].obs;
RxString tourOption = "0".obs;
RxString openCredit = "0".obs;
Rx<int> totalDays =
    Rx(departureDate.value.difference(arrivalDate.value).inDays);
var dayleft = totalDays;
Rx<double> customerAge =
    Rx(DateTime.now().difference(birthDate.value).inDays / 365);
Rx<int> memoryDayLeft = Rx(globalctx.memory["days_left"]);
// Rx<int> daysLeft = Rx(-memoryDayLeft.value + totalDays.value);
final currentDayFormat = DateFormat('EEEE MMMM d yyyy');
final dayFormat = DateFormat('d-MM-yyyy');
var experiences = processCatalog("experiences");
RxList<Widget> explist = <Widget>[].obs;
RxList<Widget> destlist = <Widget>[].obs;
Map<String, dynamic> states = {
  "selected": globalctx.selectedExperiences,
  "suggested": globalctx.suggestedExperiences,
  "promoted": globalctx.promotedExperiences
};
var travelRhytmAges = {
  20: ["1", "2", "3"],
  40: ["1", "2", "3"],
  60: ["1", "2"],
  80: ["1", "2"],
  100: [
    "1",
  ],
};
Rx<List<String>> refresh = Rx(<String>[]);
Rx<int> trigger = Rx(0);
Stream? stream;
final formKey = GlobalKey<FormState>();
var memory = globalctx.memory.value;
var detsdata = getValue(memory, "destinations", def: []);
var allDestinations = memory["destinations"];
var destinationList = allDestinations.entries
    .map((e) => {"destination": e.key.toString(), ...e.value})
    .toList();
List<dynamic> customDestinationData = [
  ...destinationList,
];
var promotedDestinations = [
  ...globalctx.promotedDestinations.value,
];
RxInt selectedIndex = 0.obs;
RxString travelCode = "".obs;
RxString leadPassenger = "".obs;
RxString arrivalPort = "0".obs;
RxString departurePort = "0".obs;
RxString destCountry = "0".obs;
var selectedDestinations = globalctx.destinations;
var destinationsCatalog = processCatalog("destinations");

var destinationCountry = processCatalog("destination_country");
var arrival = {}.obs;
var departure = {}.obs;

var airportCatalog = processCatalog("airport");

RxInt draggable = 0.obs;

List pageList = ["Tour", "Logistic", "Customer", "Destination", "Experiences"];

RxInt accumulated = 0.obs;
