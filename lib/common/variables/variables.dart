// ignore_for_file: prefer_function_declarations_over_variables, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../index.dart';

RxList selectedDestinations = [].obs;
RxList promotedDestinations = [].obs;
var destinationDragData = Rx(<Widget>[]);
bool isFirstLaunch = true;
var currentDestinationIndex = 0.obs;
var defaultToken;
Context globalctx = Context();
var session = {};
////
Rx<int> leftAccumulated = 0.obs;
var airports = {"1": "quito", "2": "guayaquil"};
Rx<int> currentDay = 0.obs;
Rx<int> currentDestination = 0.obs;
var result = [];
var globalDestinationName = Rx("quito");
var globalDestinationType = Rx("arrival");
var globalDestinationIndex = Rx("0");
var serviceSuggestedDragData = Rx(<Widget>[]);
var servicePromotedDragData = Rx(<Widget>[]);
var promotedCatalogs = [];
var promotedServices = [];
var suggestedServices = [];
var daysOff = [];
int accDays = 0;
var destDays = [];
List destList = getParam("DESTINATION_DATA").values.toList();
CatalogDto destinationData = CatalogDto(destList);
Map<dynamic, dynamic> destinations = globalctx.memory["destinations"] ?? {};
Rx<DateTime> birthDate =
    Rx(DateTime.parse(globalctx.memory["customer"]["birth_date"]));
Rx<DateTime> arrivalDate = Rx(DateTime(2022, 12, 10));
RxString arrivalDateName =
    DateFormat('EEEE').format(arrivalDate.value).toString().obs;
Rx<DateTime> departureDate = Rx(DateTime(2022, 12, 12));
RxString departureDateName =
    DateFormat('EEEE').format(departureDate.value).toString().obs;
Rx<DateTime> currentDate =
    Rx(arrivalDate.value.add(Duration(days: currentDay.value)));
RxString currentDateName =
    DateFormat('EEEE').format(currentDate.value).toString().obs;
Rx<DateTime> firstDayDate = Rx(arrivalDate.value.add(const Duration(days: 1)));
RxString firstDayDateName =
    DateFormat('EEEE').format(firstDayDate.value).toString().obs;
Rx<DateTime> lastDayDate =
    Rx(departureDate.value.add(const Duration(days: -1)));
RxString lastDayDateName =
    DateFormat('EEEE').format(lastDayDate.value).toString().obs;
var openDays = {
  "Mon": "M",
  "Tue": "T",
  "Wed": "W",
  "Thu": "Th",
  "Fri": "F",
  "Sat": "S",
  "Sun": "Su"
};
Rx<DateTime> penultimateDayDate =
    Rx(departureDate.value.subtract(const Duration(days: 1)));
Rx<DateTime> iHStartDate = Rx(firstDayDate.value);
Rx<DateTime> iHEndDate = Rx(penultimateDayDate.value);
Rx<DateTime> cruiseStartDate = Rx(firstDayDate.value);
Rx<DateTime> cruiseEndDate = Rx(penultimateDayDate.value);

Rx<DateTime> sinceDate = Rx(DateTime.now());
Rx<DateTime> untilDate = Rx(DateTime.now());
RxList<String> ocDays = <String>[].obs;
RxString tourOption = "1".obs;
Rx<int> totalDays =
    Rx(departureDate.value.difference(arrivalDate.value).inDays + 1);
RxInt accumulated = 0.obs;
RxInt selected = 0.obs;
RxInt dayleft = 0.obs;
Rx<double> customerAge =
    Rx(DateTime.now().difference(birthDate.value).inDays / 365);
Rx<int> memoryDayLeft = Rx(globalctx.memory["days_left"]);
final currentDayFormat = DateFormat('EEEE MMMM d yyyy');
final dayFormat = DateFormat('d-MM-yyyy');
List filteredsrv = [];
var services =
    getCatalogs(["hotel", "transport_service", "cruises", "food_services"])
        .then((value) => value);
var experiences = findCatalog("experiences");
List expList = findCatalog("experiences").toList();
var experienceSelectedDragData = Rx(<Widget>[]);
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
var memory = globalctx.memory;
var detsdata = getValue(memory, "destinations", def: []);
var allDestinations = memory["destinations"];
var destinationList = allDestinations.entries
    .map((e) => {"destination": e.key.toString(), ...e.value})
    .toList();
List<dynamic> customDestinationData = [
  ...destinationList,
];
RxInt selectedIndex = 0.obs;
RxString travelCode = (() {
  try {
    globalctx.memory["customer"]["travel_code"] =
        leadPassenger.value.toString() +
            "-" +
            globalctx.memory["tour"]["passengers"] +
            "-" +
            dayFormat.format(arrivalDate.value).replaceAll(" ", "-") +
            "-" +
            globalctx.memory["tour"]["code"].toString();
    return (globalctx.memory["customer"]["travel_code"]).obs;
  } catch (e) {
    return (leadPassenger.value.toString()).obs;
  }
})();
var galapagos = Rx(getFormValue(globalctx.memory, "tour", "galapagos", false));
RxString leadPassenger = "pp".obs;
RxString arrivalPort = "6".obs;
RxString departurePort = "6".obs;
RxString destCountry = "1".obs;
var destinationsCatalog = findCatalog("destinations");
var destinationCountry = findCatalog("destination_country");
var arrival = {}.obs;
var departure = {}.obs;

var airportCatalog = findCatalog("airport");

RxInt destDraggable = 0.obs;
RxInt expDraggable = 1.obs;
RxInt srvDraggable = 1.obs;
RxString arrivalState = getDestinationState("", 0).toString().obs;
RxString departureState =
    getDestinationState("", destinations.length - 1).toString().obs;

Rx<dynamic> transportService = Rx(getFormValue(globalctx.memory["destinations"],
        globalDestinationIndex.value, "service_type", <String>[]) ??
    <String>[]);
Rx<dynamic> translatingService = Rx(getFormValue(
    globalctx.memory["destinations"],
    globalDestinationIndex.value,
    "translating_service", <String>[]));
Rx<int> guide = Rx(getFormValue(globalctx.memory["destinations"],
    globalDestinationIndex.value, "guide_type", 1));
Rx<int> openBoolCredit =
    Rx(getFormValue(globalctx.memory, "logistic", "open_credit", 0));
Rx<int> arrivalDinner =
    Rx(getFormValue(globalctx.memory, "logistic", "dinner", 0));
Rx<int> openCredit =
    Rx(getFormValue(globalctx.memory, "logistic", "open_credit_value", 100));
RxBool openGuide = false.obs;
RxBool openTranslate = false.obs;
Rx<String> arrivalHour = Rx(getFormValue(
    globalctx.memory["destinations"], 0, "arrival_value", "00:00"));

var serviceTypeCatalog = Rx(findCatalog("service_type"));
var translatingCatalog = Rx(findCatalog("translating_service"));

var currentDestinationTr =
    getDestinationTravelRhythm(globalDestinationName.value, "arrival");
var currentDestinationTrRange = currentDestinationTr["value"];
var currentDestinationTrMinRange = Rx(currentDestinationTrRange["min"]);
var currentDestinationTrMaxRange = Rx(currentDestinationTrRange["max"]);
var currentDestinationType = "arrival";
var currentDestinationKeyActivities = [].obs;
var leftHours = {}.obs;
var endHours = {}.obs;
var trMaxHourValues = {
  "SOFT": 1,
  "MEDIUM": 1,
  "HARD": 3,
  "0": 3,
  "1": 1,
  "2": 1,
  "3": 3,
  0: 3,
  1: 1,
  2: 1,
  3: 3
};
var trMaxValues = {
  "SOFT": 6.0,
  "MEDIUM": 8.0,
  "HARD": 10.0,
  "0": 10.0,
  "1": 6.0,
  "2": 8.0,
  "3": 10.0,
  0: 10.0,
  1: 6.0,
  2: 8.0,
  3: 10.0
};
var trAgeMaxValues = {
  "SOFT": [60, 99],
  "MEDIUM": [40, 59],
  "HARD": [0, 39],
  "0": [60, 99],
  "1": [0, 39],
  "2": [40, 59],
  "3": [60, 99],
  0: [60, 99],
  1: [0, 39],
  2: [40, 59],
  3: [60, 99]
};
var accumulatedHours = {}.obs;
var clearedHours = {}.obs;
var clearedKA = {}.obs;
var totalHours = {}.obs;
var currentTravelRhythm = "1".obs;
var currentDestinationOption = "0".obs;
final TimeOfDay time = TimeOfDay(hour: 7, minute: 15);
Rx<TimeOfDay?> startTime = Rx(time);
Rx<TimeOfDay?> endTime = Rx(time);

var searcherHeader = Rx(<DataColumn>[]);
var searcherDetail = Rx(<DataRow>[]);
var netRateHeader = Rx(<DataColumn>[]);
var netRateDetail = Rx(<DataRow>[]);
List netRateData = [
  {"room_type": "single", "quantity": "16", "passengers": "16", "roh": "3000"},
  {"room_type": "double", "quantity": "2", "passengers": "2", "roh": "2000"},
];
List data = [];
RxString? searchResult = ''.obs;
RxList<Map<String, dynamic>> daysCatalog = <Map<String, dynamic>>[].obs;

List filtered = [];
int idx = 0;
String type = "";
List filteredExperiences = [];
var filteredData = [].obs;
var absorvedPurpose = false.obs;
var purposeMemory = <String>[].obs;
var kaMemory = <String>[].obs;
var generated = false;
var customerTypeCatalog = findCatalog("legal_client_type");
var client = globalctx.memory["customer"];
var tour = globalctx.memory["tour"];
Rx<List<Map<String, dynamic>>> citylist = Rx([]);
RxString customerType = client["client_type_id"].toString().obs;
RxString country = getValue(client, "origin_id", def: "1").toString().obs;
RxString city = getValue(client, "city_id", def: "0").toString().obs;

List<Map<String, dynamic>> countrylist = [];
Map<dynamic, dynamic> countries = getContext("countries");
Rx<List<Map<String, dynamic>>> countrydata = Rx((() {
  log("Countries: $countries\n\n");
  countrylist = [];
  var index = 0;
  if (countries != null) {
    for (var country in countries.keys) {
      countrylist.add({
        "code": "$index",
        "description": country,
      });
      index++;
    }
  }

  log("CountryList: $countrylist");
  return countrylist;
})());

var cruiseTable = Rx(
  DataTable(
    columns: searcherHeader.value,
    rows: searcherDetail.value,
  ),
);

var hotelTable = Rx(
  DataTable(
    columns: searcherHeader.value,
    rows: searcherDetail.value,
  ),
);

var moreFilters = false.obs;
List pageList = [
  {
    "label": "Tour",
    "icon": Icons.travel_explore,
    "color": Colors.green,
    "key": GlobalKey()
  },
  {
    "label": "Logistic",
    "icon": Icons.cases_sharp,
    "color": Colors.green,
    "key": GlobalKey()
  },
  {
    "label": "Customer",
    "icon": Icons.person,
    "color": Colors.green,
    "key": GlobalKey()
  },
  {
    "label": "Destination",
    "icon": Icons.place,
    "color": Colors.green,
    "key": GlobalKey()
  },
  {
    "label": "Experiences",
    "icon": Icons.access_time,
    "color": Colors.green,
    "key": GlobalKey()
  },
  {
    "label": "Services",
    "icon": Icons.hotel,
    "color": Colors.green,
    "key": GlobalKey()
  },
  {
    "label": "Resume",
    "icon": Icons.shopping_cart,
    "color": Colors.green,
    "key": GlobalKey()
  },
  {
    "label": "PrintDocs",
    "icon": Icons.print,
    "color": Colors.green,
    "key": GlobalKey()
  },
];
