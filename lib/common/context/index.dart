// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:property_change_notifier/property_change_notifier.dart';
import '../index.dart';

// ignore: mixin_inherits_from_not_object
class Context with PropertyChangeNotifier<String> {
  Rx<Map<String, dynamic>> context = Rx({
    "dayleft": 9999,
    "index": 0.obs,
    "icons": {}.obs,
    "countries": {},
    "session": {"avatar": "".obs},
    "destinationdata": {}.obs,
    "experiencedata": {}.obs,
    "catalogs": {}.obs
  }.obs);
  Rx<List<Widget>> destinationDragData = Rx(<Widget>[]);
  RxMap destinationState = {}.obs;
  Rx<Map<dynamic, List<Widget>>> experienceDragData = Rx({});
  Rx<Map<dynamic, List<Widget>>> servicePromotedDragData = Rx({});
  Rx<Map<dynamic, List<Widget>>> serviceSuggestedDragData = Rx({});
  RxBool value = true.obs;
  RxBool reset = false.obs;
  RxList destinations = [].obs;
  RxMap services = {}.obs;
  RxMap experiences = {}.obs;
  RxList<dynamic> destinationlist = [].obs;
  RxList<dynamic> experiencelist = [].obs;
  RxList<dynamic> servicelist = [].obs;
  RxList promotedDestinations = [].obs;
  RxList promotedDays = [].obs;
  RxList selectedDestinations = [].obs;
  var promotedServices = {}.obs;
  var promotedExperiences = {}.obs;
  var selectedExperiences = {}.obs;
  var suggestedExperiences = {}.obs;
  RxMap<String, dynamic> states = {
    "services": {},
    "experiences": {},
    "destinations": {},
  }.obs;
  var payload = {};
  RxMap<String, dynamic> memory = {
    "services": {},
    "tour": {},
    "logistic": {},
    "customer": {},
    "destinations": {},
    "destinationDay": [],
    "days": {},
    "days_left": 0
  }.obs;
  int counter = 0;
  Map<String, GlobalKey<State<StatefulWidget>>> keys = {};
  Context() {
    load("countries");
  }

  void set_context(key, value) {
    context.value[key] = value;
    notifyListeners(key);
  }

  dynamic get_context(key) {
    return context.value[key];
  }
}

setContext(key, value) {
  globalctx.set_context(key, value);
  log(globalctx.context.value);
}

getContext(key) {
  return globalctx.get_context(key);
}
