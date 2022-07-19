import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../index.dart';

class LocalContext extends Context {
  LocalContext() {
    loadDummyData("countries");
    loadDummyData("global");
  }
  
  Rx<List<Widget>> destinationDragData = Rx(<Widget>[]);
  RxMap destinationState = {}.obs;
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
    "catalogs": {},
    "tour": {},
    "logistic": {},
    "customer": {},
    "destinations": {},
    "destinationDay": [],
    "days": {},
    "experiences": {},
    "services": {},
    "promoted": {},
    "netRate": {},
    "days_left": 0
  }.obs;
  int counter = 0;
  Map<String, GlobalKey<State<StatefulWidget>>> keys = {};
}