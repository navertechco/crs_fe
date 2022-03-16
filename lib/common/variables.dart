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
var globalDestinationName = Rx("");
var globalDestinationType = Rx("");
var globalDestinationIndex = Rx("");

RxInt destDays = 0.obs;
List destList = getParam("DESTINATION_DATA").values.toList();
CatalogDto destinationData = CatalogDto(destList);
Map<dynamic, dynamic> destinations = globalctx.memory["destinations"] ?? {};
Rx<DateTime> birthDate =
    Rx(DateTime.parse(globalctx.memory["customer"]["birth_date"]));
Rx<DateTime> arrivalDate = Rx(DateTime(2022, 12, 10));
Rx<DateTime> departureDate = Rx(DateTime(2022, 12, 15));
Rx<DateTime> sinceDate = Rx(DateTime.now());
Rx<DateTime> untilDate = Rx(DateTime.now());
RxList<String> ocDays = <String>[].obs;
RxString tourOption = "1".obs;
RxString openCredit = "0".obs;
Rx<int> totalDays =
    Rx(departureDate.value.difference(arrivalDate.value).inDays);
RxInt accumulated = 1.obs;
RxInt selected = 0.obs;
RxInt dayleft = 0.obs;
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
var promotedDestinations = globalctx.promotedDestinations.value;
RxInt selectedIndex = 0.obs;
RxString travelCode = (leadPassenger.value.toString() +
        "-" +
        globalctx.memory["tour"]["passengers"] +
        "-" +
        dayFormat.format(arrivalDate.value).replaceAll(" ", "-"))
    .obs;
RxString leadPassenger = "pp".obs;
RxString arrivalPort = "6".obs;
RxString departurePort = "6".obs;
RxString destCountry = "1".obs;
var selectedDestinations = globalctx.destinations;
var destinationsCatalog = processCatalog("destinations");
var experiencesCatalog = processCatalog("experiences");

var destinationCountry = processCatalog("destination_country");
var arrival = {}.obs;
var departure = {}.obs;

var airportCatalog = processCatalog("airport");

RxInt draggable = 0.obs;

List pageList = [
  "Tour",
  "Logistic",
  "Customer",
  "Destination",
  "Experiences",
  "Resume"
];

RxString arrivalState = getDestinationState("", 0).toString().obs;
RxString departureState =
    getDestinationState("", destinations.length - 1).toString().obs;

Function validateDestinationDialog = (destination, type) {
  var rule1 = (draggable.value == 0 && type == "arrival");
  var rule2 = (draggable.value != 0 &&
      type == "tour" &&
      destination != arrival["description"] &&
      destination != departure["description"]);
  var rule3 = (draggable.value != 0 &&
      globalctx.promotedDestinations.length !=
          globalctx.selectedDestinations.length &&
      globalctx.promotedDestinations.length >=
          globalctx.selectedDestinations.length - 1 &&
      globalctx.selectedDestinations.length >= 3 &&
      globalctx.promotedDestinations.length >= 2 &&
      type == "departure");
  var rule4 = globalctx.selectedDestinations.contains(destination);
  var rule5 = accumulated.value > 0;
  var rule6 = dayleft.value > 0;
  return (((rule1 || rule2 || rule3) && rule4 ||
              (rule1 || rule2 || rule3) && rule5) &&
          rule6)
      .obs;
};

List<Map<String, dynamic>> tourTemplate = [
  {
    "code": "country",
    "description": "country",
    "value": "1",
    "convert": true,
    "label": "Destination Country",
    "def": ""
  },
  {
    "code": "accomodation_type",
    "description": "accomodation_type",
    "value": "1",
    "convert": true,
    "label": "Accomodation Type",
    "def": ""
  },
  {
    "code": "purpose",
    "description": "purpose",
    "value": "1",
    "convert": true,
    "label": "Purpose",
    "def": ""
  },
  {
    "code": "passengers",
    "description": "passengers",
    "value": "1",
    "convert": true,
    "label": "Passengers",
    "def": ""
  },
];

List<Map<String, dynamic>> customerTemplate = [
  {
    "code": "contact_name",
    "description": "contact_name",
    "value": "1",
    "convert": true,
    "label": "Contact Name",
    "def": ""
  },
  {
    "code": "legal_client_type",
    "description": "legal_client_type",
    "value": "1",
    "convert": true,
    "label": "Legal Client",
    "def": "Natural"
  },
  {
    "code": "customer_type",
    "description": "customer_type",
    "value": "1",
    "convert": true,
    "label": "Customer Type",
    "def": ""
  },
  {
    "code": "country",
    "description": "country",
    "value": "1",
    "convert": true,
    "label": "Country",
    "def": "Ecuador"
  },
  {
    "code": "email",
    "description": "email",
    "value": "1",
    "convert": true,
    "label": "e-Mail",
    "def": ""
  },
  {
    "code": "travel_code",
    "description": "travel_code",
    "value": "1",
    "convert": true,
    "label": "Travel Code",
    "def": "000000"
  },
  {
    "code": "lead_passenger",
    "description": "lead_passenger",
    "value": "1",
    "convert": true,
    "label": "Lead Passenger",
    "def": ""
  },
  {
    "code": "address_line",
    "description": "address_line",
    "value": "1",
    "convert": true,
    "label": "Address Line",
    "def": ""
  },
  {
    "code": "city",
    "description": "city",
    "value": "1",
    "convert": true,
    "label": "City",
    "def": ""
  },
  {
    "code": "dni",
    "description": "dni",
    "value": "1",
    "convert": true,
    "label": "DNI/PASSPORT",
    "def": "000000"
  },
  {
    "code": "tax_id",
    "description": "tax_id",
    "value": "1",
    "convert": true,
    "label": "TAX-ID",
    "def": "000000"
  },
  {
    "code": "names",
    "description": "names",
    "value": "1",
    "convert": true,
    "label": "Names",
    "def": ""
  },
  {
    "code": "last_names",
    "description": "last_names",
    "value": "1",
    "convert": true,
    "label": "Last Names",
    "def": ""
  },
  {
    "code": "birth_date",
    "description": "birth_date",
    "value": "1",
    "convert": false,
    "label": "Birth Date",
    "def": ""
  },
];

List<Map<String, dynamic>> logisticTemplate = [
  {
    "code": "arrival_date",
    "description": "arrival_date",
    "value": "1",
    "convert": true,
    "label": "Arrival Date",
    "def": ""
  },
  {
    "code": "departure_date",
    "description": "departure_date",
    "value": "1",
    "convert": true,
    "label": "Departure Date",
    "def": ""
  },
];

Rx<dynamic> transportService = Rx(getFormValue(globalctx.memory["destinations"],
        globalDestinationIndex.value, "service_type", <String>[]) ??
    <String>[]);
Rx<dynamic> translatingService = Rx(getFormValue(
    globalctx.memory["destinations"],
    globalDestinationIndex.value,
    "translating_service", <String>[]));
Rx<int> guide = Rx(getFormValue(globalctx.memory["destinations"],
    globalDestinationIndex.value, "guide_type", 1));

Rx<int> guideIndex = Rx(
    transportService.value.indexWhere((element) => element == "GUIDING") ?? 0);
Rx<int> translateIndex = Rx(
    transportService.value.indexWhere((element) => element == "TRANSLATING") ??
        0);

var serviceTypeCatalog = Rx(processCatalog("service_type"));
var translatingCatalog = Rx(processCatalog("translating_service"));

var currentDestinationTr =
    getDestinationTravelRhythm(globalDestinationName.value).obs;
var currentDestinationTrRange = currentDestinationTr["value"];
var currentDestinationTrMinRange = Rx(currentDestinationTrRange["min"]);
var currentDestinationTrMaxRange = Rx(currentDestinationTrRange["max"]);
