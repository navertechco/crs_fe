// ignore_for_file: prefer_function_declarations_over_variables, import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:yaml/yaml.dart';


// ooooooooooooo                                     oooooooooooo                                       .    o8o                                 
// 8'   888   `8                                     `888'     `8                                     .o8    `"'                                 
//      888       .ooooo.  oooo  oooo  oooo d8b       888         oooo  oooo  ooo. .oo.    .ooooo.  .o888oo oooo   .ooooo.  ooo. .oo.    .oooo.o 
//      888      d88' `88b `888  `888  `888""8P       888oooo8    `888  `888  `888P"Y88b  d88' `"Y8   888   `888  d88' `88b `888P"Y88b  d88(  "8 
//      888      888   888  888   888   888           888    "     888   888   888   888  888         888    888  888   888  888   888  `"Y88b.  
//      888      888   888  888   888   888           888          888   888   888   888  888   .o8   888 .  888  888   888  888   888  o.  )88b 
//     o888o     `Y8bod8P'  `V88V"V8P' d888b         o888o         `V88V"V8P' o888o o888o `Y8bod8P'   "888" o888o `Y8bod8P' o888o o888o 8""888P' 
                                                                                                                                              
                                                                                                                                              
         

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
        for (String exp in exps.keys) {
          Map newExp = {};
          Map newEntry = exps[exp];
          newExp = {...myExpDto, ...newEntry};
          myDayDto["experiences"] ??= {};
          myDayDto["experiences"][exp] = newExp;
        }
        destinations[dest]["daysData"][dayIndex] = myDayDto;
        dayIndex++;
      }
    }
    globalctx.memory["resume"] = destinations;

    try {
      for (var dest in globalctx.memory["resume"].keys) {
        if (globalctx.memory["resume"][dest] != null) {
          globalctx.memory["resume"][dest] =
              globalctx.memory["resume"][dest].value;
        }
      }
    } catch (e) {
      log(e);
    }

    globalctx.payload["tour"] = globalctx.memory["tour"];
    globalctx.payload["logistic"] = globalctx.memory["logistic"];
    globalctx.payload["customer"] = globalctx.memory["customer"];
    globalctx.payload["destinations"] = globalctx.memory["resume"];
    globalctx.payload["days"] = globalctx.memory["days"];
    globalctx.payload["totalDays"] = globalctx.memory["totalDays"];
    globalctx.payload["promoted"] = globalctx.memory["promoted"];

    if (translatingService.value.isNotEmpty) {
      globalctx.payload["tour"]["passengers"] =
          (int.parse(globalctx.payload["tour"]["passengers"]) + 1).toString();
    }

    try {
      for (var day in globalctx.payload["days"].keys) {
        globalctx.payload["days"][day] = globalctx.payload["days"][day].value;
      }
    } catch (e) {
      log(e);
    }

    globalctx.payload["logistic"]["arrival_date"] =
        globalctx.payload["logistic"]["arrival_date"].toString();
    globalctx.payload["logistic"]["since_date"] =
        globalctx.payload["logistic"]["since_date"].toString();
    globalctx.payload["logistic"]["departure_date"] =
        globalctx.payload["logistic"]["departure_date"].toString();
    globalctx.payload["logistic"]["until_date"] =
        globalctx.payload["logistic"]["until_date"].toString();
    await saveTour();
  } catch (e) {
    log(e);
  } finally {
    gotoPage("PrintDocs");
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
    var res = await fetchHandler(
        kDefaultSchema,
        kDefaultServer,
        kDefaultServerPort,
        kDefaultTourEdit,
        'POST',
        {"state": "new", "id": globalctx.memory["tour"]["code"], "data": data});
    if (res.statusCode == 200 && res["state"]) {
      globalctx.memory["tour"]["playlist_slug"] = res["data"]["playlist_slug"];
      generated = true;
    }
  } catch (e) {
    generated = false;
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
    SweetAlert.show(ctx,
        curve: ElasticInCurve(),
        title: res['message'],
        style: SweetAlertStyle.error, onPress: (bool isConfirm) {
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
  var res = await fetchHandler(kDefaultSchema, kDefaultServer,
      kDefaultServerPort, kDefaultNewTourEdit, 'POST', {"id": 1});
  if (res['state'] == true) {
    globalctx.memory["tour"]["code"] = res['data']["id"];
    setContext("catalogs", res['data']["catalogs"]);
    selectedIndex.value = 0;
    Get.toNamed("/Tour");
  } else {
    log(res["message"]);
  }
}
