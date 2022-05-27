// ignore_for_file: prefer_function_declarations_over_variables
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/pages/5/destination/widgets/index.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sweetalert/sweetalert.dart';
import '../index.dart';

dragDestination(destination) {
  addDestination(destination);
  filterDestinations();
}

getDestinationList() {
  List<Widget> destinationlist = [];
  List destinations = destinationsCatalog.toList();

  orderDestination(destinations);
  for (Map item in destinations) {
    List itemList = item.values.toList();
    CatalogDto destination = CatalogDto(itemList);

    destinationlist.add(
      CustomDragableDestination(destination: destination.description!),
    );
  }
  return destinationlist;
}

orderDestination(List destinations) {
  if (arrival.isNotEmpty) {
    destinations.sort((a, b) {
      var arrivalData = toCatalog(filterCatalog(
          "destinations", "description", arrival.value["description"])[0]);
      var arrivalLat = arrivalData.relation["latitude"];
      var arrivalLong = arrivalData.relation["longitude"];
      var aLat = toCatalog(a).relation["latitude"];
      var bLat = toCatalog(b).relation["latitude"];
      var aLong = toCatalog(a).relation["longitude"];
      var bLong = toCatalog(b).relation["longitude"];
      var bDistance = (getDistance(bLat, bLong, arrivalLat, arrivalLong));
      var aDistance = (getDistance(aLat, aLong, arrivalLat, arrivalLong));
      return aDistance.compareTo(bDistance);
    });
  }
}

promote(destination, index, type) {
  setDestinationState(destination, index, "promoted", type);
  updateDraggableDestinations();
  updateTotalLeftAccumulated();
}

promoteDestination(ctrl, _formKey, destination, index, type) {
  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();
    if (!globalctx.promotedDestinations.contains(index)) {
      globalctx.promotedDestinations.add(index);
      destinations = globalctx.memory["destinations"];
    }
    arrivalState.value = "selected";
    departureState.value = "selected";
    if (globalctx.promotedDestinations.isNotEmpty) {
      arrivalState.value = "promoted";
    }
    promote(destination, index, type);
    Get.close(1);
  }
}

updateDraggableDestinations() {
  arrivalState.value = getDestinationState(arrival["description"], 0);
  if (arrivalState.value == "promoted" &&
      globalctx.promotedDestinations.length == 1) {
    destDraggable.value = 1;
  }
  if (arrivalState.value == "promoted" &&
      departureState.value == "promoted" &&
      globalctx.promotedDestinations.length ==
          globalctx.selectedDestinations.length) {
    destDraggable.value = 0;
  }
}

//  Functions
getDestinationAirport() {
  var airport = "quito";
  try {
    return airport;
  } catch (e) {
    return airport;
  }
}

getCombinedDestinations() {
  var memoryDestinations = {};
  for (var destination in destinations.entries) {
    var key = destination.key;
    var value = destination.value;
    memoryDestinations = {...memoryDestinations, key: value};
  }
  destinations = memoryDestinations;
  return destinations;
}

processDestinations(context) async {
  // ignore: unrelated_type_equality_checks
  if (globalctx.promotedDestinations.isNotEmpty & (dayleft == 0)) {
    var destinationDay = [];
    experiencePromotedDragData.value = <Widget>[];

    var destinations = getCombinedDestinations();
    int idx = 0;
    for (var destination in destinations.entries.toList()) {
      var dest = destinations[idx.toString()];
      var explorationDay = dest["explorationDay"];
      var days = int.parse(explorationDay);
      destinationDay.add({...dest, "destination": destination, "days": days});
      accDays += days;
      idx++;
    }
    globalctx.memory["destinationDay"] = destinationDay;
    globalctx.memory["totalDays"] = totalDays.value;
    arrival.value = getDestinationById(arrivalPort.value);
    departure.value = getDestinationById(departurePort.value);
    globalDestinationName.value = arrival["description"];
    globalDestinationType.value = "arrival";
    globalDestinationIndex.value = "0";
    currentDay.value = -1;
    await nextDay();
  } else {
    if (context != null) {
      SweetAlert.show(context,
          curve: ElasticInCurve(),
          title: (dayleft.value > 0)
              ? "You still have $dayleft days to enjoy, do you want to review the other options we have for you?"
              : "Promote any destination is required",
          style: SweetAlertStyle.error, onPress: (bool isConfirm) {
        Get.close(1);
        return false;
      });
    }
  }
}

removeDestination(String destination) {
  if (globalctx.destinations.contains(destination)) {
    globalctx.destinations.remove(destination);
  }
}

addDestination(String destination) {
  if (!globalctx.destinations.contains(destination) &&
      !globalctx.selectedDestinations.contains(destination)) {
    globalctx.destinations.add(destination);
  }
}

filterSelectedDestinations() {
  var galapagos = getFormValue(globalctx.memory, "tour", "galapagos", false);
  if (dayleft.value > 1 &&
      globalctx.promotedDestinations.length >=
          globalctx.selectedDestinations.length - 1) {
    if (selectedDestinations.contains(arrival["description"])) {
      selectedDestinations.remove(arrival["description"]);
    }

    if (selectedDestinations.contains("galapagos")) {
      selectedDestinations.remove("galapagos");
    }

    if (selectedDestinations.contains(departure["description"])) {
      selectedDestinations.remove(departure["description"]);
    }
    selectedDestinations.insert(0, arrival["description"]);
    if (galapagos) {
      selectedDestinations.insert(1, "galapagos");
      removeDestination("galapagos");
      addDestination("galapagos");
      setDestinationState("galapagos", 1, "selected", "tour");
    }

    selectedDestinations.add(departure["description"]);
    globalctx.selectedDestinations.value = [];
    globalctx.destinationDragData.value = <Widget>[];
    idx = 0;
    var destlength = selectedDestinations.length;
    for (var selected in selectedDestinations) {
      type = "tour";
      if (idx == 0) {
        type = "arrival";
      }
      if (idx == destlength - 1) {
        type = "departure";
      }
      moveDestination(selected, idx, type);
      idx++;
    }
  }
}

moveDestination(String destination, int index, String type) {
  setDestinationState(destination, index, "selected", type);
  globalctx.selectedDestinations.add(destination);
  globalctx.destinationDragData.value.add(DragDestinationWidget(
      destination: destination, index: index, type: type, out: false));
}

removeDestinationFrom(memory, destination) {
  try {
    var index = memory.indexWhere((element) => element == destination);
    setDestinationState(destination, index, "suggested", type);
    memory.removeAt(index);
  } catch (e) {
    log(e);
  }
}

deleteDestination(String destination) {
  if (destination != arrival["description"] ||
      destination != departure["description"]) {
    var index =
        globalctx.destinations.indexWhere((element) => element == destination);
    globalctx.destinationDragData.value.removeAt(index);
    removeDestinationFrom(globalctx.promotedDestinations,
        getDestinationIndex(destination, "tour"));
    removeDestinationFrom(globalctx.selectedDestinations, destination);
    removeDestinationFrom(globalctx.destinations, destination);
    downgradeDestination(destination, index);
  }
}

downgradeDestination(String destination, index) {
  if (globalctx.memory["destinations"].keys.contains(index.toString())) {
    accumulated -= int.parse(getFormValue(globalctx.memory["destinations"],
        index.toString(), "explorationDay", "0"));
    dayleft += int.parse(getFormValue(globalctx.memory["destinations"],
        index.toString(), "explorationDay", "0"));
  }
  if (destination == "galapagos") {
    iHStartDate = Rx(firstDayDate.value);
    iHEndDate = Rx(penultimateDayDate.value);
    cruiseStartDate = Rx(firstDayDate.value);
    cruiseEndDate = Rx(penultimateDayDate.value);
  }
}

getDestinationById(destId) {
  try {
    var dest = destinationsCatalog
        .toList()
        .where((element) => element["code"] == int.parse(destId))
        .first;
    return dest;
  } catch (e) {
    log(e);
  }
}

getDestinationIdByName(String destination) {
  var id = getDestinationByName(destination)["code"].toString();
  return id;
}

getDestinationValueByName(String destination) {
  var result = [];
  try {
    result = getDestinationByName(destination)["value"];
  } catch (e) {
    log(e);
  }
  return result;
}

getDestinationByName(String destination) {
  var result;
  try {
    List<Map<String, dynamic>> list = destinationsCatalog.toList();
    result = list.firstWhere(
        (element) => element["description"].toString() == destination);
  } catch (e) {
    log(e);
  }
  return result;
}

setDestinationState(String dest, index, state, type) {
  globalctx.states["destinations"][index] ??= {}.obs;
  globalctx.states["destinations"][index]["state"] = state;
  globalctx.states["destinations"][index]["type"] = type;
  globalctx.states["destinations"][index]["index"] = index;
  globalctx.states["destinations"][index]["destination"] = dest;
}

getDestinationState(destination, index) {
  var state = "suggested";
  globalctx.states["destinations"][index] ??= {}.obs;
  state = globalctx.states["destinations"][index]["state"] ?? "suggested";
  return state;
}

updateTotalLeftAccumulated() {
  accumulated.value = 0;
  if (destinations.isNotEmpty) {
    for (var destination in destinations.keys) {
      accumulated.value += getDestinationDay(destination) as int;
    }
  }
  dayleft.value = totalDays.value - accumulated.value;
}

setDestination(String destination, index) {
  index = index.toString();
  destinations[index] ??= {};
}

setDestinationDay(String destination, index, value) {
  index = index.toString();
  setDestination(destination, index);
  destinations[index]["explorationDay"] ??= value;
}

getLeftAccumulated(destination, id) {
  leftAccumulated.value = 0;
  for (String item in destinations.keys) {
    bool exists = item != destination;
    if (exists) {
      leftAccumulated.value -= getDestinationDay(item) as int;
    }
  }
  return leftAccumulated.value;
}

getMaxTrValue(tr) {
  return trMaxValues[tr];
}

getMaxTrHourValue(tr) {
  return trMaxHourValues[tr];
}

getAgeMaxTrValue(tr) {
  return trAgeMaxValues[tr];
}

getDestinationIndexByDay() {
  var _left = 0;
  var _accumulated = 0;
  var _destinations = globalctx.memory["destinations"];

  if (currentDay.value <= 0) {
    return 0;
  }

  for (var i = 0; i < _destinations.length; i++) {
    var _dest = _destinations[i.toString()];
    var _explorationDay = _dest["explorationDay"];
    _accumulated += int.parse(_explorationDay);
    _left = totalDays.value - _accumulated;
    if (_left <= currentDay.value) {
      return i;
    }
  }
}

getDestinationIndex(String destination, String type) {
  int destIndex = 0;
  var destinations = globalctx.states["destinations"].entries;
  for (var e in destinations) {
    if (e.value["destination"] == destination && e.value["type"] == type) {
      destIndex = e.value["index"];
    }
  }
  if (type == "arrival") {
    destIndex = 0;
  }
  if (type == "departure") {
    destIndex = globalctx.promotedDestinations.length - 1;
  }
  return destIndex;
}

getDestinationDestOption(destination, type) {
  int destIndex = getDestinationIndex(destination, type);
  var destData = globalctx.memory["destinations"][destIndex.toString()];
  var trData = findCatalog("detination_option").toList();
  var trRange = trData
      .firstWhere((e) => e["code"] == int.parse(destData["detination_option"]));
  return trRange;
}

getDestinationTravelRhythm(destination, type) {
  int destIndex = getDestinationIndex(destination, type);
  var destData = globalctx.memory["destinations"][destIndex.toString()];
  var trData = findCatalog("travel_rhythm").toList();
  var trRange = trData
      .firstWhere((e) => e["code"] == int.parse(destData["travel_rhythm"]));
  return trRange;
}

getDestinationKa(destination, type) {
  int destIndex = getDestinationIndex(destination, type);
  var destData = globalctx.memory["destinations"][destIndex.toString()];
  return destData["key_activities"];
}

filterDestinations() {
  var arr = getDestinationById(arrivalPort.value);
  var dep = getDestinationById(departurePort.value);
  arrival.value = arr;
  departure.value = dep;
  filterSelectedDestinations();
}

getDestinationDay(index) {
  index = index.toString();
  if (destinations[index] != null) {
    if (destinations[index]["explorationDay"] != null) {
      return int.parse(destinations[index]["explorationDay"]);
    }
  }
  return 0;
}

updateCurrentDestination() {
  var type = "tour";
  if (currentDay.value == 0) {
    type = "arrival";
  }
  if (currentDay.value == totalDays.value - 1) {
    type = "departure";
  }
  currentDestinationType = type;
  globalDestinationType.value = type;
}

resetDestinations() {
  destDraggable.value = 0;
  allPromotedDestinations.value = [];
  globalctx.promotedDestinations.value = [];
  globalctx.selectedDestinations.value = [];
  globalctx.destinations.value = [];
  globalctx.destinationDragData.value = [];
  globalctx.memory["destinations"] = {};
  globalctx.states["destinations"] = {};
  arrivalState.value = "selected";
  departureState.value = "selected";
}

getSubs(String destination) {
  var res = <Map<String, dynamic>>[];
  try {
    var destData = getDestinationValueByName(destination);
    var subs = destData[9]["subs"];
    if (subs.length > 0) {
      for (var sub in subs) {
        res.add(sub);
      }
    }
  } catch (e) {
    log(e);
  }
  return res;
}

filterTrByAge() {
  var tr = findCatalog("travel_rhythm");
  var filtered = tr.toList();
  var birthDate = globalctx.memory["customer"]["birth_date"];
  var age = DateTime.now().difference(DateTime.parse(birthDate)).inDays / 365;
  filtered = tr.toList().where((e) {
    var range = getAgeMaxTrValue(e["description"].toString().toUpperCase());
    // var min = range[0];
    var max = range[1];
    var rule2 = age <= max;
    var rule = rule2;
    return rule;
  }).toList();
  Iterable result = filtered;
  return result;
}
