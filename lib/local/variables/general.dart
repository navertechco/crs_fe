// ignore_for_file: prefer_function_declarations_over_variables, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

bool isFirstLaunch = true;
var defaultToken;
double ratio = Get.height / Get.width;
bool isMobileLayout = Get.width < 600 || Get.height < 600;
bool mob = isMobileDevice() & isMobileLayout;

double isMobile = ratio * (mob ? 1 : 1.5);
LocalContext globalctx = LocalContext();
var session = {};
////
Rx<int> leftAccumulated = 0.obs;
var airports = {"1": "quito", "2": "guayaquil"};
var currentDay = 0.obs;
Rx<int> currentDestination = 0.obs;
var result = [];
var promotedCatalogs = [];
var daysOff = [];
int accDays = 0;
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
Map dayDto = {
  "date": '',
  "observation": '',
  "day_description": '',
  "day_name": '',
  "parent": 0,
  "option_id": 1,
  "transport_id": 1,
  "key_activities": [],
  "meals": "B/L/D/O",
  "experiences": {},
  "destination": ''
};
var days = [
  {"dayId": 1, "spa": "Lunes", "eng": "Monday"},
  {"dayId": 2, "spa": "Martes", "eng": "Tuesday"},
  {"dayId": 3, "spa": "Miercoles", "eng": "Wednesday"},
  {"dayId": 3, "spa": "Miércoles", "eng": "Wednesday"},
  {"dayId": 4, "spa": "Jueves", "eng": "Thursday"},
  {"dayId": 5, "spa": "Viernes", "eng": "Friday"},
  {"dayId": 6, "spa": "Sabado", "eng": "Saturday"},
  {"dayId": 6, "spa": "Sábado", "eng": "Saturday"},
  {"dayId": 7, "spa": "Domingo", "eng": "Sunday"}
];
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
RxString leadPassenger = "pp".obs;
RxString arrivalPort = "6".obs;
RxString departurePort = "6".obs;
var arrival = {}.obs;
var departure = {}.obs;
var airportCatalog = findCatalog("airport");
RxInt expDraggable = 1.obs;
RxInt srvDraggable = 1.obs;
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
var transportService = "0".obs;
Rx<List<String>> translatingService = Rx(
    getFormValue(globalctx.memory, "tour", "translating_service", <String>[]));
Rx<int> openBoolCredit =
    Rx(getFormValue(globalctx.memory, "logistic", "open_credit", 0));
Rx<int> arrivalDinner =
    Rx(getFormValue(globalctx.memory, "logistic", "dinner", 0));
Rx<int> openCredit =
    Rx(getFormValue(globalctx.memory, "logistic", "open_credit_value", 100));
RxBool openGuide = false.obs;
RxBool openTranslate = false.obs;
var serviceTypeCatalog = Rx(findCatalog("service_type"));
var translatingCatalog = Rx(findCatalog("translating_service"));
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
Map trMaxValues = {
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
Map trAgeMaxValues = {
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
List filtered = [];
int idx = 0;
String type = '';
var filteredData = [].obs;
var absorvedPurpose = false.obs;
var purposeMemory = <String>[].obs;
var kaMemory = <String>[].obs;
var generated = false;
var tour = globalctx.memory["tour"];
Rx<List<Map<String, dynamic>>> citylist = Rx([]);
RxString customerType = client["client_type_id"].toString().obs;
RxString country = getValue(client, "origin_id", def: "1").toString().obs;
RxString city = getValue(client, "city_id", def: "0").toString().obs;
List<Map<String, dynamic>> countrylist = [];
Map<dynamic, dynamic> countries = getContext("countries");
var currentCountry = "Ecuador".obs;
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
var moreFilters = false.obs;
