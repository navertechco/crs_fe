// ignore_for_file: prefer_function_declarations_over_variables
import 'package:flutter/material.dart';
import '../index.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:yaml/yaml.dart';
import 'package:naver_crs/index.dart';
import 'package:naver_crs/index.dart';

/// ## processTour
/// *__Method to prepare all memory data to send it to backend__*
///
///### Uses:
/// ```dart
///  processTour()
/// ```
/// ### Returns:
///```dart
/// void
///```
processTour() async {
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
    goto("PrintDocs");
  }
}

saveTour() async {
  try {
    var payload = globalctx.payload.toString();
    var yaml = loadYaml(payload);
    var data = (yaml.toString());
    var res = await fetchhandler(
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

getTour(ctx, {int tourId = 0, detail = false, cb}) async {
  var frame = {
    "data": {"tour_id": tourId, "detail": detail}
  };
  var res = await fetchhandler(kDefaultSchema, kDefaultServer,
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

getTourPurpose() {
  var purposes = globalctx.memory["tour"]["purposes"];
  return purposes;
}

newTour() async {
  var res = await fetchhandler(kDefaultSchema, kDefaultServer,
      kDefaultServerPort, kDefaultNewTourEdit, 'POST', {});
  if (res['state'] == true) {
    globalctx.memory["tour"]["code"] = res['data']["id"];
    setContext("catalogs", res['data']["catalogs"]);
    selectedIndex.value = 0;
    Get.toNamed("/Tour");
  } else {
    log(res["message"]);
  }
}
