// ignore_for_file: non_constant_identifier_names, prefer_function_declarations_over_variables

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:naver_crs/pages/6/experiences/widgets/custom/draggable/moveExperience.dart';
import 'package:naver_crs/pages/6/experiences/widgets/custom/index.dart';
import 'package:sweetalert/sweetalert.dart';
import 'context/index.dart';
import 'index.dart';

/*
 * DATOS DE SERVIDOR
 */

Function removeFromArray = (array, item) {
  if (array.contains(item)) {
    var index = array.indexOf(item);
    array.value.removeAt(index);
    if (globalctx.experienceDragData.value[currentDay.value]!.isNotEmpty) {
      if (globalctx.experienceDragData.value[currentDay.value]!.length ==
          array.value.length) {
        globalctx.experienceDragData.value[currentDay.value]!.removeAt(index);
      } else {
        var newIndex = index > 0 ? index - 1 : 0;
        globalctx.experienceDragData.value[currentDay.value]!
            .removeAt(newIndex);
      }
    }
  }
};

Function removeExperience = (experience) {
  removeFromArray(globalctx.selectedExperiences, experience);
  removeFromArray(globalctx.promotedExperiences, experience);
};

var KTextSytle = (context, fontSize, fontWeight) => GoogleFonts.poppins(
        textStyle: TextStyle(
      color: Color.fromARGB(255, 0, 0, 0),
      fontSize: MediaQuery.of(context).size.width /
          MediaQuery.of(context).size.height *
          fontSize,
      fontWeight: fontWeight ?? FontWeight.normal,
    ));

const kDefaultSchema = "http";
const kDefaultServer = "192.168.101.4";
const kDefaultServerPort = 9999;
const kDefaultCatalogPath = "/System/FindCatalog";
const kDefaultQueryPath = "/Agent/Query";
const kDefaultDestinationPath = "/Agent/GetDestination";
const kDefaultExperiencePath = "/Agent/GetExperience";
const kDefaultConnectPath = "/User/Connect";
const kDefaultSendPollPath = "/Gamer/SendPoll";
const kDefaultBuyCreditsPath = "/Gamer/BuyCredit";
const kDefaultJoinTournmanetPath = "/Gamer/JoinTournament";

//DIMENSIONES
var kDefaultPadding = 20.0;
const kDefaultRadius = BorderRadius.all(Radius.circular(8.0));
const kFontSize = 72.0;
var kSize = getContext('size');

///COLORES

const kPrimaryColor = Color(0xFFFFFFFF);
const kPrimaryLightColor = Color(0xFFF6F6F6);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFFFFF), Color(0xFFF6F6F6)],
);
const kSecondaryColor = Color(0xFFE0E0E0);
const kTextColor = Color(0xFF0D0D0D);
const kTextLightColor = Color(0xFFB4B4B4);
const kBlueColor = Color(0xFF40BAD5);
const kShadowColor = Color(0xFFE0E0E0);
const kShadowLightColor = Color(0xFFB4B4B4);
const kShadowDarkColor = Color(0xFF707070);
const kShadowGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF707070), Color(0xFFB4B4B4)],
);

const kBackgroundColor = Color(0xFFF6F6F6);

//BORDES
const kDefaultBorder = BorderRadius.all(Radius.circular(8.0));
const kDefaultBorderLight = BorderRadius.all(Radius.circular(4.0));
const kDefaultBorderDark = BorderRadius.all(Radius.circular(4.0));
const kDefaultBorderGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF707070), Color(0xFFB4B4B4)],
);
const kDefaultBorderGradientLight = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFB4B4B4), Color(0xFF707070)],
);
const kDefaultBorderGradientDark = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF707070), Color(0xFFB4B4B4)],
);
const kDefaultBorderGradientLightDark = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFB4B4B4), Color(0xFF707070)],
);
const kDefaultBorderGradientDarkLight = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFB4B4B4), Color(0xFF707070)],
);
const kDefaultBorderGradientDarkDark = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFB4B4B4), Color(0xFF707070)],
);
const kDefaultBorderGradientLightLight = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFB4B4B4), Color(0xFF707070)],
);

//VALIDADORES
final passwordValidator = MultiValidator(
  [
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ],
);

final idValidator = MultiValidator(
  [
    RequiredValidator(errorText: 'id is required'),
    MinLengthValidator(10, errorText: 'id must be at least 10 digits long'),
    PatternValidator(r'^[0-9]*$', errorText: 'id must have only numbers')
  ],
);

class MaxIntValidator extends FieldValidator<int> {
  int maxValue;
  MaxIntValidator({required String errorText, required this.maxValue})
      : super(errorText);

  @override
  bool isValid(value) {
    if (value > maxValue) return false;
    return true;
  }
}

final maxValidator = MultiValidator(
  [
    RequiredValidator(errorText: 'id is required'),
    MaxIntValidator(errorText: 'mayyor a 100', maxValue: 100),
    PatternValidator(r'^[0-9]*$', errorText: 'id must have only numbers')
  ],
);

final isMobileDevice = () {
  if ((defaultTargetPlatform == TargetPlatform.iOS) ||
      (defaultTargetPlatform == TargetPlatform.android)) {
    // Some android/ios specific code
    return true;
  }
  return false;
};

final chunkMap =
    (Map<String, dynamic> data, int portion, List<Map<String, dynamic>> list) {
  List<List<Map<String, dynamic>>> chunks = [];
  if (data != null) {
    int aprox = (list.length / portion).round() * portion;
    int module = aprox > list.length
        ? (list.length / portion).round()
        : (list.length / portion).round() + 1;

    for (var i = 0; i < module; i++) {
      chunks.add([]);
      for (var j = 0; j < portion; j++) {
        var index = (i * portion) + j;
        if (index > list.length - 1) {
          break;
        }
        Map<String, dynamic> item = list[index];
        String code = item["code"];
        item["value"] = data[code];
        chunks[i].add(item);
      }
    }
  }

  return chunks;
};

Future<bool> getCatalog(
  List<String> catalogs,
) async {
  var res = await fetchhandler(kDefaultSchema, kDefaultServer,
      kDefaultServerPort, kDefaultCatalogPath, 'POST', {
    "data": {"catalogs": catalogs}
  });
  // ignore: avoid_print
  // print(res);
  if (res['state'] == true) {
    setContext("catalogs", res['data']);
    return true;
  } else {
    return false;
  }
}

Function processCatalog = (name) {
  var ctxCatalogs = getContext("catalogs");

  if (ctxCatalogs != null) {
    var catalogs = ctxCatalogs["catalogs"];
    List<Map<String, dynamic>> catalog = [];
    var items = catalogs[name];
    if (items != null) {
      for (var item in items) {
        Map<String, dynamic> row = {};
        row["code"] = item["code"];
        row["description"] = item["description"];
        row["value"] = item["value"];
        catalog.add(row);
      }
    }

    return catalog;
  }

  return <Map<String, dynamic>>[];
};

Function getValue = (data, key, {def}) {
  if (data != null && data.length > 0) {
    if (data[key] != null) {
      return data[key];
    }
  }

  return def;
};

Function validateData = (data) {
  return data != null ? data.length > 0 : false;
};

var getData = (data, sub, key) {
  // ignore: invalid_use_of_protected_member
  return data != null && data[sub] != null
      // ignore: invalid_use_of_protected_member
      ? data[sub][key]
      : "0";
};

var getDataList = (data, sub, key) {
  // ignore: invalid_use_of_protected_member
  return data != null && data[sub] != null
      // ignore: invalid_use_of_protected_member
      ? data[sub][key]
      : <Map<String, dynamic>>[];
};

Function getParam = (key) {
  var params = processCatalog("params");
  var child =
      params.toList().firstWhere((element) => element["description"] == key);
  return child;
};

Function cityData = (Rx<List<Map<String, dynamic>>> citylist, cities) {
  var index = 0;
  citylist.value = [];

  for (var city in cities) {
    citylist.value.add({
      "code": "$index",
      "description": city,
    });
    index++;
  }
};

var getExperiences = (String destination,
    String experience,
    List<int>? keyActivities,
    List<int>? travelRhythms,
    int? destinationOption) async {
  var res = await fetchhandler(kDefaultSchema, kDefaultServer,
      kDefaultServerPort, kDefaultExperiencePath, 'POST', {
    "data": {
      "destination": destination,
      "experience": experience,
      "key_activities": keyActivities ?? [],
      "travel_rhythms": travelRhythms ?? [],
      "destination_option": destinationOption
    }
  });

  if (res['state'] == true) {
    setContext("experiences", res['data']);
    return true;
  } else {
    return false;
  }
};
Rx<int> leftAccumulated = 0.obs;

var globalctxReset = () {
  globalctx.promotedDestinations.value = [];
  globalctx.selectedDestinations.value = [];
  globalctx.destinations.value = [];
  globalctx.experiences.value = [];
  globalctx.destinationDragData.value = [];
  globalctx.experienceDragData.value = {};
  globalctx.reset.value = true;
  totalDays.value = departureDate.value.difference(arrivalDate.value).inDays;
  leftAccumulated.value = 0;
  setContext("dayleft", totalDays.value);
};

class CustomRequiredValidator extends TextFieldValidator {
  final ctx;
  CustomRequiredValidator({required String errorText, required this.ctx})
      : super(errorText);

  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(String? value) {
    return value != null && value != "0" && value != "0";
  }

  @override
  String? call(String? value) {
    if (isValid(value)) {
      return null;
    } else {
      SweetAlert.show(ctx,
          title: errorText,
          subtitle: 'error',
          style: SweetAlertStyle.error, onPress: (bool isConfirm) {
        Get.close(1);
        return false;
      });
      return errorText;
    }
  }
}

var CustomDatetimeRequiredValidator =
    (DateTime? date, {BuildContext? context, required String errorText}) {
  if (date == null) {
    SweetAlert.show(context,
        title: errorText,
        subtitle: 'error',
        style: SweetAlertStyle.error, onPress: (bool isConfirm) {
      Get.close(1);
      return true;
    });
  }
};

var CustomMultiDropdownRequiredValidator = (List<Map<String, dynamic>>? value,
    {BuildContext? context, required String errorText}) {
  if (value == null) {
    SweetAlert.show(context,
        title: errorText,
        subtitle: 'error',
        style: SweetAlertStyle.error, onPress: (bool isConfirm) {
      Get.close(1);
      return true;
    });
  }
};

Function setData = (data, key, value) {
  data[key] = value;
};

Function getFormValue = (data, formKey, key, def) {
  if (data != null) {
    if (data[formKey] != null) {
      return data[formKey][key];
    }
  }
  return def;
};

Function setFormValue = (data, formKey, key, value) {
  data ??= {}.obs;

  if (data[formKey] == null) {
    data[formKey] = {};
  }

  data[formKey][key] = value;
};

var airports = {"1": "quito", "2": "guayaquil"};

Rx<int> currentDay = 0.obs;

Function getAirport = (destination) {
  var airport = "quito";
  try {
    var destinationData = getParam("DESTINATION_DATA")["value"];
    var destinations = globalctx.promotedDestinations.value;
    var first = destinations[1];
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

Function processDays = (day) {
  var result = [];
  result.add({"day": 1, "destination": "arrival"});
  var destinations = globalctx.memory["destinationDay"];
  for (var dest in destinations) {
    for (var i = 1; i <= dest["days"]; i++) {
      result.add({"day": i, "destination": dest["destination"]});
    }
  }
  result.add({"day": 1, "destination": "departure"});
  return result[day.value];
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

  var allPromotedDEstinations = [
    "arrival",
    ...globalctx.promotedDestinations.value,
    "departure"
  ];

  for (var i = 0; i < totalDays.value; i++) {
    globalctx.experienceDragData.value[i] ??= <Widget>[];
    // globalctx.promotedExperiences[i] ??= [].obs;
  }

  for (var destination in allPromotedDEstinations) {
    var dest = destinations[destination];
    var explorationDays = dest["explorationDay"];
    var days = int.parse(explorationDays);
    destinationDay.add({...dest, "destination": destination, "days": days});
    totalDays.value += days;
  }
  globalctx.memory["destinationDay"] = destinationDay;
  globalctx.memory["totalDays"] = totalDays;
};

var destination = Rx(processDays(currentDay)["destination"]);

var getDestination = (String destination) async {
  var res = await fetchhandler(kDefaultSchema, kDefaultServer,
      kDefaultServerPort, kDefaultDestinationPath, 'POST', {
    "data": {
      "destination_name": destination,
    }
  });

  if (res['state'] == true) {
    setContext("current", res['data']);
    return res["data"];
  } else {
    return false;
  }
};
var destinationData = getParam("DESTINATION_DATA");
Map<dynamic, dynamic> destinations = getValue(destinationData, "value");
Rx<DateTime> arrivalDate = Rx(globalctx.memory["tour"]["arrival_date"]);
Rx<DateTime> departureDate = Rx(globalctx.memory["tour"]["departure_date"]);
Rx<int> totalDays =
    Rx(departureDate.value.difference(arrivalDate.value).inDays);
Rx<int> memoryDayLeft = Rx(globalctx.memory["days_left"]);
Rx<int> daysLeft = Rx(-memoryDayLeft.value + totalDays.value);
final currentDayFormat = DateFormat('EEEE MMMM d yyyy');

Function findDestination = (destination) {
  var promotedDestinations = globalctx.promotedDestinations.value;
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

var experiences = getContext("experiences");

Function deleteExperience = (experience) {
  if (globalctx.experiences.contains(experience)) {
    var index =
        globalctx.experiences.indexWhere((element) => element == experience);
    globalctx.experiences.removeAt(index);
    globalctx.experienceDragData.value[currentDay.value]!.removeAt(index);
  }
};

Function filterExperienceList = (data, day) {
  String travelRhythm = data["travelRhythm"];
  List? currentList = globalctx.promotedExperiences.value[day];
  Iterable filtered =
      currentList!.where((e) => e["travelRhythm"] == travelRhythm);

  for (var experience in filtered) {}

  globalctx.promotedExperiences.value[day] = filtered.toList();
};

Function proccessExperiences = () {
  for (var experience in experiences) {
    var state = getExperienceState(experience["title"]);
    states[state][experience["title"]] = true;
  }
};

Function setExperienceState = (experience, state) {
  globalctx.states["experiences"][experience] ??= {}.obs;
  globalctx.states["experiences"][experience]["state"] = state;
  proccessExperiences();
  filterSuggestedExperiences();
};

Function getExperienceState = (experience) {
  globalctx.states["experiences"][experience] ??= {}.obs;
  var state = globalctx.states["experiences"][experience]["state"];
  return state == null ? "suggested" : state;
};

Function paginateDay = (context) {
  // Get promoted experiences by day and KA
  var promotedExperiencesByDayAndKA =
      getPromotedExperiencesByDayAndKA(currentDay.value);

  //Decide if experiences are 2 almost to paginate
  if (promotedExperiencesByDayAndKA) {
    prepareDaysToResume();
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

Function getPromotedExperiencesByDayAndKA = (day) {
  // Get promoted experiences by day and KA
  List promoted = states["promoted"].entries.toList();
  var filtered = promoted.where((e) {
    return experiences.where((f) {
      return f["title"] == e.key;
    }).isNotEmpty;
  });

  return true;
};

Function prepareDaysToResume = () {
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
    "experiences": [],
    "destination": destination.value
  };

  var experience = {
    "destination": destination.value,
    "day": "",
    "title": "",
    "description": "",
    "next": "",
    "previous": "",
    "experience_id": "",
    "photo": ""
  };
  destination.value = processDays(currentDay)["destination"];
  globalctx.memory.value["days"][currentDay.value] ??= {};
  globalctx.memory.value["days"][currentDay.value] = day;
  print(globalctx.memory.value["days"]);
};

Function paginateNextDay = () {
  // Paginate to Next Day
  if (currentDay.value < totalDays.value) {
    currentDay.value += 1;
    destination.value = processDays(currentDay)["destination"];
    filterSuggestedExperiences();
  } else {
    Get.toNamed("/Resume");
  }
};

Function filterSuggestedExperiences = () {
  // Get airport from current destination
  var filteredExperiences = getFiltered(destination.value);
  // Reset suggested memory and suggested render list
  globalctx.suggestedExperiences.value = {};
  list.value = <Widget>[];
  // Add New Suggested Render Components to list
  for (var experience in filteredExperiences) {
    list.add(CustomDragableExperience(experience: experience, suggested: true));
  }
  // // Refresh memory
  // list.refresh();
  // globalctx.suggestedExperiences.refresh();
  // globalctx.experienceDragData.refresh();
  // globalctx.promotedExperiences.refresh();
};

Function getFiltered = (dest) {
  var airport = getAirport(dest).toString().toUpperCase();

  List filteredByDestination = experiences
          .where((e) => e["destination"]
              .toString()
              .toUpperCase()
              .contains(dest.toUpperCase()))
          .toList() ??
      [];

  Iterable filteredByAirport = filteredByDestination;

  if (dest == "arrival") {
    filteredByAirport = filteredByDestination
        .where((e) => e["title"].contains(airport))
        .toList();
  }

  var filteredBySuggested = filteredByAirport.where((e) {
    return getExperienceState(e["title"]) == "suggested";
  }).toList();

  return filteredBySuggested;
};

RxList<Widget> list = <Widget>[].obs;
Map<String, dynamic> states = {
  "selected": globalctx.selectedExperiences,
  "suggested": globalctx.suggestedExperiences,
  "promoted": globalctx.promotedExperiences
};
