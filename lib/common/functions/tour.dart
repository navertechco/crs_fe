// ignore_for_file: prefer_function_declarations_over_variables
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:yaml/yaml.dart';
import '../index.dart';

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
