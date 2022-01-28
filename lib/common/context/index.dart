// ignore_for_file: non_constant_identifier_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../index.dart';

// ignore: mixin_inherits_from_not_object
class Context with PropertyChangeNotifier<String> {
  Rx<Map<String, dynamic>> context = Rx({
    "dayleft": 9999,
    "index": 0.obs,
    "icons": {}.obs,
    "session": {"avatar": "".obs},
    "destinationdata": {}.obs,
    "experiencedata": {}.obs
  }.obs);
  Rx<List<Widget>> destinationDragData = Rx(<Widget>[]);
  Rx<List<Widget>> experienceDragData = Rx(<Widget>[]);
  RxBool value = true.obs;
  RxBool reset = false.obs;
  RxList destinations = [].obs;
  RxList experiences = [].obs;
  RxList<dynamic> destinationlist = [].obs;
  RxList<dynamic> experiencelist = [].obs;
  RxList promoted = [].obs;
  RxList selected = [].obs;
  RxList suggested = [].obs;
  RxMap<String, dynamic> memory = {
    "tour": {}.obs,
    "customer": {}.obs,
    "destinations": {}.obs,
    "experiences": {}.obs,
    "days": {}.obs,
    "days_left": 0.obs
  }.obs;
  Map<String, GlobalKey<State<StatefulWidget>>> keys = {};
  Context() {
    load("catalogs");
    load("data");
    load("countries");
  }

  void load(file) {
    rootBundle.loadString("assets/data/$file.json").then((value) {
      context.value[file] = json.decode(value);
    });
  }

  void set_context(key, value) {
    context.value[key] = value;
    notifyListeners(key);
  }

  dynamic get_context(key) {
    return context.value[key];
  }
}

Context globalctx = Context();
setContext(key, value) {
  globalctx.set_context(key, value);
  // print(globalctx.context.value);
}

getContext(key) {
  return globalctx.get_context(key);
}
