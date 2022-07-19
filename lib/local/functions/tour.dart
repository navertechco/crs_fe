// ignore_for_file: prefer_function_declarations_over_variables, import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';
import 'package:sweetalertv2/sweetalertv2.dart';
import 'package:yaml/yaml.dart';

// ████████╗ ██████╗ ██╗   ██╗██████╗
// ╚══██╔══╝██╔═══██╗██║   ██║██╔══██╗
//    ██║   ██║   ██║██║   ██║██████╔╝
//    ██║   ██║   ██║██║   ██║██╔══██╗
//    ██║   ╚██████╔╝╚██████╔╝██║  ██║
//    ╚═╝    ╚═════╝  ╚═════╝ ╚═╝  ╚═╝

// ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗
// ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
// █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗
// ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║
// ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║
// ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝

/// ## processTour
/// *__Method to prepare all memory data to send it to backend__*
///
///### Uses:
/// ```dart
///  processTour()
/// ```
/// ### Returns:
///```dart
/// Future
///```
Future processTour() async {
  try {
    var dayIndex = 0;
    var destinations = getCombinedDestinations();
    for (String dest in destinations.keys.toList()) {
      var destination = destinations[dest];
      destination["daysData"] ??= {};
      destination["daysData"] = {};
      destinations[dest] = destination;
      var explorationDay = destination["explorationDay"];

      for (var i = 0; i < int.parse(explorationDay); i++) {
        Map myDayDto = dayDto;
        Map myExpDto = experienceDto;
        // Prepare Frame to send to Resume Page
        var exps = globalctx.memory["promoted"][dayIndex];
        if (exps != null) {
          for (String exp in exps.keys) {
            Map newExp = {};
            Map newEntry = exps[exp];
            newExp = {...myExpDto, ...newEntry};
            myDayDto["experiences"] ??= {};
            myDayDto["experiences"][exp] = newExp;
          }
        }
        destinations[dest]["daysData"][dayIndex] = myDayDto;
        dayIndex++;
      }
    }
    preparePayloadToSend();

    await saveTour();
  } catch (e) {
    log(e);
  } finally {
    gotoPage("PrintDocs");
  }
}

preparePayloadToSend() {
  globalctx.memory["resume"] = destinations;
  globalctx.payload["resume"] = globalctx.memory["resume"];
  globalctx.payload["tour"] = globalctx.memory["tour"];
  globalctx.payload["logistic"] = globalctx.memory["logistic"];
  globalctx.payload["customer"] = globalctx.memory["customer"];
  globalctx.payload["destinations"] = globalctx.memory["resume"];
  globalctx.payload["days"] = globalctx.memory["days"];
  globalctx.payload["totalDays"] = globalctx.memory["totalDays"];
  globalctx.payload["promoted"] = globalctx.memory["promoted"];
  if (translatingService.value.isNotEmpty) {
    var passengers = globalctx.payload["tour"]["passengers"] ?? "1";
    globalctx.payload["tour"]["passengers"] =
        (parseInt(passengers) + 1).toString();
  }
}

/// ## saveTour
/// *__Method to save Tour registry to backend__*
///
///### Uses:
/// ```dart
///  await saveTour();
/// ```
/// ### Returns:
///```dart
///  Future
///```
Future saveTour() async {
  try {
    var payload = globalctx.payload.toString();
    var yaml = loadYaml(payload);
    var data = (yaml.toString());
    var tourId = globalctx.memory["tour"]["code"];
    var res = await fetchHandler(
        kDefaultSchema,
        kDefaultServer,
        kDefaultServerPort,
        kDefaultTourEdit,
        'POST',
        {"state": "new", "id": tourId, "data": data});
    if (res.statusCode == 200 && res["state"]) {
      globalctx.memory["tour"]["playlist_slug"] = res["data"]["playlist_slug"];
      generated = true;
    }
  } catch (e) {
    generated = false;
  }
}

/// ## findTravelRhythmDescription
/// *__Method to find travel Rhythm Description__*
///
///### Uses:
/// ```dart
///        label:
///      "Travel Rhythm: ${findTravelRhythmDescription(parseInt(currentTravelRhythm.value))}",
/// ```
/// ### Returns:
///```dart
/// String?
///```
String? findTravelRhythmDescription(int code) {
  try {
    if (code == 0) {
      return "HARD";
    }
    var travelData = findCatalog("travel_rhythm").toList();
    String description = travelData
        .firstWhere((element) => element["code"] == code)["description"];
    return description;
  } catch (e) {
    log(e);
  }
  return null;
}

/// ## resetFindTourData
/// *__Method reset Find Tour Data__*
///
///### Uses:
/// ```dart
///      onPressed: () {
///   resetFindTourData(context, controller);
/// },
/// ```
/// ### Returns:
///```dart
/// void
///```
void resetFindTourData(context, controller) {
  var data = globalctx.memory["tours"];
  if (searchResult!.isNotEmpty) {
    controller.clear();
    searchResult!.value = '';
    filteredData.value = data;
    var detail = getTourDataRows(context, filteredData, null);
    searcherDetail.value = (detail);
  }
}

/// ## filterFindTourData
/// *__Method reset Find Tour Data__*
///
///### Uses:
/// ```dart
///       onChanged: (value) {
///             filterFindTourData(context, value);
///            },
/// ```
/// ### Returns:
///```dart
/// void
///```
void filterFindTourData(context, value) {
  var data = globalctx.memory["tours"];
  try {
    searchResult!.value = value.toString();
    if (searchResult!.isNotEmpty) {
      filteredData.value = data
          .where((quote) =>
              quote["date"].toString().contains(searchResult!.value) ||
              quote["name"].toString().contains(searchResult!.value) ||
              quote["quote"].toString().contains(searchResult!.value))
          .toList();
      var detail = getTourDataRows(context, filteredData, null);
      searcherDetail.value = (detail);
    }
  } catch (e) {
    log(e);
  }
}

/// ## saveTranslatingServices
/// *__Method to save Translating Service in memory to backend__*
///
///### Uses:
/// ```dart
///  saveTranslatingServices(values);
/// ```
/// ### Returns:
///```dart
///  void
///```
void saveTranslatingServices(values) {
  var result = <String>[];
  for (var value in values) {
    var description = translatingCatalog.value
        .firstWhere((item) => item["code"] == value)["description"];
    result.add(description.toString());
  }
  translatingService.value = result;
  setFormValue(globalctx.memory, "tour", "translating_service", result);
}

/// ## getTour
/// *__Method to query a Tour to backend__*
///
///### Uses:
/// ```dart
///  onPressed: () {
///              getTour(context, tourId: row['quote'], detail: true,
///                cb: (data) {
///               if (data.length > 0) {
///                 globalctx.memory["tour"] = data[0];
///                 showCustomDialog(context, NetRatePage(), "Close",
///                     buttonColor: Colors.white, width: 1.0);
///               }
///             });
///           },
/// ```
/// ### Returns:
///```dart
///  Future
///```
Future getTour(ctx, {int tourId = 0, detail = false, cb}) async {
  var frame = {
    "data": {"tour_id": tourId, "detail": detail, "limit": 10, "offset": 0}
  };
  var res = await fetchHandler(kDefaultSchema, kDefaultServer,
      kDefaultServerPort, kDefaultFindTour, 'POST', frame);
  // ignore: avoid_print
  log(res);
  if (res['state'] == true) {
    var data = res['data'];
    cb(data);
  } else {
    SweetAlertV2.show(ctx,
        curve: ElasticInCurve(),
        title: res['message'],
        style: SweetAlertV2Style.error, onPress: (bool isConfirm) {
      Get.close(1);
      return false;
    });
  }
}

/// ## newTour
/// *__Method to get NewTour Id from backend__*
///
///### Uses:
/// ```dart
///  onPressed: () async {
///                         setContext("readonly", false);
///                      await newTour();
///                     }),
/// ```
/// ### Returns:
///```dart
///  Future
///```
Future newTour() async {
  try {
    var res = await fetchHandler(kDefaultSchema, kDefaultServer,
        kDefaultServerPort, kDefaultNewTourEdit, 'POST', {"id": "1"});

    if (res['state'] == true) {
      globalctx.memory["tour"]["code"] = res['data']["id"];
      // setContext("catalogs", res['data']["catalogs"]);
      selectedIndex.value = 0;
      Get.toNamed("/Tour");
    } else {
      log(res);
    }
  } catch (e) {
    log(e);
  }
}
