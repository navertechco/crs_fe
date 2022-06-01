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

globalctxReset() {
  globalctx.reset.value = true;
  resetLeftDays();
  resetDestinations();
  updateDraggableDestinations();
  filterDestinations();
  if (cruiseDay.value.isNotEmpty) {
    autoFillDestination(arrival["description"], 0, "arrival", "1");
    autoFillDestination("galapagos", 1, "arrival", cruiseDay.value);
    autoFillDestination(departure["description"], 2, "departure", "1");
  }
}

autoFillDestination(destination, index, type, days) {
  setFormValue(globalctx.memory["destinations"], index, "explorationDay", days);
  setFormValue(globalctx.memory["destinations"], index, "type", type);
  setFormValue(globalctx.memory["destinations"], index, "index", index);
  setFormValue(
      globalctx.memory["destinations"], index, "destination", destination);
  setFormValue(
      globalctx.memory["destinations"], index, "key_activities", ["SURPRISE"]);
  setFormValue(globalctx.memory["destinations"], index, "travel_rhythm",
      destination == "galapagos" ? "3" : "1");
  setFormValue(globalctx.memory["destinations"], index, "explorationMode",
      destination == "galapagos" ? "1" : "0");
  addDestination(destination);
  promote(destination, index, type);
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
  updatePromotedDestination(destination, index);
  setDestinationState(destination, index, "promoted", type);
  updateDraggableDestinations();
  updateTotalLeftAccumulated();
}

promoteDestination(ctrl, _formKey, destination, index, type) {
  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();
    promote(destination, index, type);
    Get.close(1);
  }
}

updatePromotedDestination(destination, index) {
  if (!globalctx.promotedDestinations.contains(index)) {
    globalctx.promotedDestinations.add(index);
    destinations = globalctx.memory["destinations"];
  }
  arrivalState.value = "selected";
  departureState.value = "selected";
  if (globalctx.promotedDestinations.isNotEmpty) {
    arrivalState.value = "promoted";
  }
}

updateDraggableDestinations() {
  if (arrivalState.value == "promoted" &&
      globalctx.promotedDestinations.length >=
          globalctx.selectedDestinations.length - 1) {
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

addDestination(String destination) {
  var newIndex = globalctx.destinations.length - 1;
  if (!globalctx.destinations.contains(destination)) {
    globalctx.destinations.insert(newIndex, destination);
  }
  // moveDownDestinationState(
  //     departure["description"], newIndex, "selected", "departure");

  setDestinationState(destination, newIndex, "selected", "tour");
}

moveDownDestinationState(dest, index, state, type) {
  globalctx.states["destinations"][index + 1] =
      globalctx.states["destinations"][index];
  globalctx.states["destinations"][index + 1]["destination"] =
      globalctx.states["destinations"][index]["destination"];
  globalctx.states["destinations"][index + 1]["index"] =
      globalctx.states["destinations"][index]["index"];
  globalctx.states["destinations"][index + 1]["state"] =
      globalctx.states["destinations"][index]["state"];
  globalctx.states["destinations"][index + 1]["type"] =
      globalctx.states["destinations"][index]["type"];
  globalctx.memory["destinations"][(index + 1).toString()] =
      globalctx.memory["destinations"][(index).toString()];
  globalctx.promotedDestinations.remove(index);
  globalctx.promotedDestinations.add(index + 1);
  setDestinationState(
      departure["description"], index + 1, "selected", "departure");
  globalctx.memory["destinations"][(index).toString()] = null;
  globalctx.states["destinations"][index] = null;
  cleanDestinations(globalctx.states["destinations"]);
  cleanDestinations(globalctx.memory["destinations"]);
}

validateDestinationDialog(destination, index, type) {
  var galapagos = getFormValue(globalctx.memory, "tour", "galapagos", false);
  var isArrival = index == 0 && type == "arrival";
  var days = int.parse(getFormValue(
      globalctx.memory["destinations"], index, "explorationDay", "0"));
  var isDeparture =
      destination == departure["description"] && type == "departure";
  var isSelected = getDestinationState(destination, index, type) == "selected";
  var isSuggested =
      getDestinationState(destination, index, type) == "suggested";
  var isPromoted = getDestinationState(destination, index, type) == "promoted";
  var isArrivalPromoted =
      getDestinationState(arrival["description"], 0, "arrival") == "promoted";
  var isTour = !isArrival && !isDeparture;
  var isDepartureConsistent = (destDraggable.value != 0 &&
      globalctx.promotedDestinations.length !=
          globalctx.selectedDestinations.length &&
      globalctx.promotedDestinations.length >=
          globalctx.selectedDestinations.length - 1 &&
      globalctx.selectedDestinations.length >= 3 &&
      globalctx.promotedDestinations.length >= 2 &&
      type == "departure");
  var isAccumulated = accumulated.value > 0;
  var isDayleft = dayleft.value > 0;
  var arrivalRule = isArrival && isSelected && isDayleft;
  var cruiseFirstDayDirefferece =
      cruiseStartDate.value.difference(arrivalDate.value).inDays;
  var preArrival =
      isArrival && galapagos && isDayleft && cruiseFirstDayDirefferece > 1;
  var departureRule = isDeparture &&
      isDepartureConsistent &&
      isSelected &&
      isArrivalPromoted &&
      isAccumulated &&
      isDayleft;
  var tourRule = isTour && isArrivalPromoted && isAccumulated && isDayleft;
  if (galapagos && days > 0) {
    return ((isPromoted || isSelected || isTour)).obs;
  }
  return ((preArrival || arrivalRule || departureRule || tourRule)).obs;
}

filterSelectedDestinations() {
  var galapagos = getFormValue(globalctx.memory, "tour", "galapagos", false);
  if (dayleft.value > 1 &&
      globalctx.promotedDestinations.length >=
          globalctx.selectedDestinations.length - 1) {
    if (selectedDestinations.contains(arrival["description"])) {
      selectedDestinations.remove(arrival["description"]);
    }

    if (selectedDestinations.contains("galapagos") || galapagos) {
      selectedDestinations.remove("galapagos");
    }
    if (selectedDestinations.contains(departure["description"])) {
      selectedDestinations.remove(departure["description"]);
    }
    selectedDestinations.insert(0, arrival["description"]);
    if (galapagos) {
      selectedDestinations.insert(1, "galapagos");
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
  var state = "selected";
  // if (globalctx.promotedDestinations.contains(index)) {
  //   state = "promoted";
  // }
  setDestinationState(destination, index, state, type);
  globalctx.selectedDestinations.add(destination);
  globalctx.destinationDragData.value.add(DragDestinationWidget(
      destination: destination, index: index, type: type, out: false));
}

deleteDestination(String destination) {
  if (arrivalPort.value != getDestinationIdByName(destination) &&
      departurePort.value != getDestinationIdByName(destination) &&
      globalctx.destinations.contains(destination)) {
    globalctx.promotedDestinations.remove(destination);
    var index =
        globalctx.destinations.indexWhere((element) => element == destination);
    var type = "tour";
    setDestinationState(destination, index, "suggested", type);
    globalctx.destinations.removeAt(index);
    globalctx.selectedDestinations.removeAt(index);
    globalctx.destinationDragData.value.removeAt(index);
    var destDay = int.parse(getFormValue(globalctx.memory["destinations"],
        index.toString(), "explorationDay", "0"));
    var destinationExists =
        globalctx.memory["destinations"].keys.contains(index.toString());

    if (destinationExists) {
      accumulated -= destDay;
      dayleft += destDay;
    }

    if (destination == "galapagos") {
      iHStartDate = Rx(firstDayDate.value);
      iHEndDate = Rx(penultimateDayDate.value);
      cruiseStartDate = Rx(firstDayDate.value);
      cruiseEndDate = Rx(penultimateDayDate.value);
    }
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

cleanDestinations(memory) {
  for (var dest in memory.entries.toList()) {
    if (dest.value == null) {
      memory.remove(dest.key);
    }
  }
}

setDestinationState(dest, index, state, type) {
  globalctx.states["destinations"][index] ??= {}.obs;
  globalctx.states["destinations"][index]["destination"] = dest;
  globalctx.states["destinations"][index]["index"] = index;
  globalctx.states["destinations"][index]["state"] = state;
  globalctx.states["destinations"][index]["type"] = type;
}

getDestinationState(destination, index, type) {
  var state = "suggested";
  globalctx.states["destinations"][index] ??= {}.obs;
  state = globalctx.states["destinations"][index]["state"] ?? "suggested";
  if (globalctx.states["destinations"][index]["type"] != type) {
    state = "suggested";
  }
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
