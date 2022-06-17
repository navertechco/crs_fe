// ignore_for_file: prefer_function_declarations_over_variables
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';
import '../index.dart';
import 'index.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';
import 'package:naver_crs/pages/5/destination/widgets/index.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sweetalert/sweetalert.dart';

/// ## dragDestination
/// *__Method to drag a destinatio option widget to left container and account it__*
///
///### Uses:
/// ```dart
///   onAccept = (String destination) {
///      dragDestination(destination);
///    };
/// ```
/// ### Returns:
///```dart
/// void
///```
dragDestination(destination) {
  addDestination(destination);
  filterDestinations();
}
/// ## paginateDestination
/// *__Method to get any property in data__*
///
///### Uses:
/// ```dart
///          onPressed: () async {
///            await paginateDestination("prev");
///           },
/// ```
/// ### Returns:
///```dart
///  Future
///```
Future paginateDestination(String direction) async {
  int sum = direction == "next" ? 1 : -1;
  if (currentDestination.value + sum >= 0 &&
      currentDestination.value + sum <
          globalctx.memory["destinations"].length) {
    currentDestination.value = currentDestination.value + sum;
    globalDestinationIndex.value = currentDestination.value.toString();
    try {
      globalDestinationName.value = globalctx
          .memory["destinations"][globalDestinationIndex.value]
          .value["destination"];
    } catch (e) {
      globalDestinationName.value = "quito";
    }

    globalDestinationType.value = "tour";

    if (currentDestination.value == 0) {
      globalDestinationType.value = "arrival";
    }
    if (currentDestination.value ==
        globalctx.memory["destinations"].length - 1) {
      globalDestinationType.value = "departure";
    }

    log("currentDestination.value: ${currentDestination.value}");
    filterSuggestedServices();
  } else if (currentDestination.value + sum >
      globalctx.memory["destinations"].length - 1) {
    gotoPage("Resume");
  } else {
    gotoPage("Experiences");
  }
}
/// ## resetAllDestinations
/// *__Method to reset all destination options__*
///
///### Uses:
/// ```dart
///
///      resetAllDestinations();
///
/// ```
/// ### Returns:
///```dart
/// void
///```
void resetAllDestinations() {
  globalctx.reset.value = true;
  resetLeftDays();
  resetDestinations();
  updateDraggableDestinations();
  filterDestinations();
  if (cruiseDay.isNotEmpty) {
    autoFillDestination(arrival["description"], 0, "arrival", "1");
    autoFillDestination("galapagos", 1, "arrival", cruiseDay.value);
    autoFillDestination(departure["description"], 2, "departure", "1");
  }
}

/// ## resetLeftDays
/// *__Method to reset Destination day variables from memory__*
///
///### Uses:
/// ```dart
///  resetLeftDays()
/// ```
/// ### Returns:
///```dart
/// void
///```
void resetLeftDays() {
  leftAccumulated.value = 0;
  dayleft.value = totalDays.value;
  accumulated.value = 0;
}

/// ## autoFillDestination
/// *__Method to auto fill destination options__*
///
///### Uses:
/// ```dart
///autoFillDestination(arrival["description"], 0, "arrival", "1");
///
/// ```
/// ### Returns:
///```dart
/// void
///```
void autoFillDestination(destination, index, type, days) {
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
  processDestinationPromotion(destination, index, type);
}

/// ## getDestinationList
/// *__Method to get destination list__*
///
///### Uses:
/// ```dart
///getDestinationList();
///
/// ```
/// ### Returns:
///```dart
/// List
///```
List getDestinationList() {
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

/// ## orderDestination
/// *__Method to order destinations__*
///
///### Uses:
/// ```dart
///  orderDestination(destinations);
/// ```
///
/// @return void
///
void orderDestination(List destinations) {
  if (arrival.isNotEmpty) {
    destinations.sort((a, b) {
      var arrivalData = toCatalog(filterCatalog(
          "destinations", "description", arrival["description"])[0]);
      var arrivalLat = arrivalData.relation["latitude"];
      var arrivalLong = arrivalData.relation["longitude"];
      var aLat = toCatalog(a).relation["latitude"];
      var bLat = toCatalog(b).relation["latitude"];
      var aLong = toCatalog(a).relation["longitude"];
      var bLong = toCatalog(b).relation["longitude"];
      var bDistance = (getGPSDistance(bLat, bLong, arrivalLat, arrivalLong));
      var aDistance = (getGPSDistance(aLat, aLong, arrivalLat, arrivalLong));
      return aDistance.compareTo(bDistance);
    });
  }
}

/// ## processDestinationPromotion
/// *__Method to promote destination__*
///
///### Uses:
/// ```dart
///  processDestinationPromotion(destination, index, type);
/// ```
///
/// @return void
///
void processDestinationPromotion(destination, index, type) {
  updatePromotedDestination(destination, index);
  setDestinationState(destination, index, "promoted", type);
  updateDraggableDestinations();
  updateTotalLeftAccumulated();
}

/// ## promoteDestination
/// *__Method to promote destination__*
///
///### Uses:
/// ```dart
///   onNext: () {
///                  promoteDestination(ctrl, _formKey, destination, index, type);
///                },
/// ```
///
/// @return void
///
void promoteDestination(ctrl, _formKey, destination, index, type) {
  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();
    processDestinationPromotion(destination, index, type);
    Get.close(1);
  }
}

/// ## updatePromotedDestination
/// *__Method to update a promoted destination__*
///
///### Uses:
/// ```dart
///   updatePromotedDestination(destination, index);
/// ```
///
/// @return void
///
void updatePromotedDestination(destination, index) {
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

/// ## updateDraggableDestinations
/// *__Method to update a draggable destinations__*
///
///### Uses:
/// ```dart
///   updateDraggableDestinations();
/// ```
///
/// @return void
///
void updateDraggableDestinations() {
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

/// ## getCombinedDestinations
/// *__Method to get combined destinations whit memory__*
///
///### Uses:
/// ```dart
///   var destinations = getCombinedDestinations();
/// ```
///
/// @return Map
///
Map getCombinedDestinations() {
  var memoryDestinations = {};
  for (var destination in destinations.entries) {
    var key = destination.key;
    var value = destination.value;
    memoryDestinations = {...memoryDestinations, key: value};
  }
  destinations = memoryDestinations;
  return destinations;
}

/// ## processDestinations
/// *__Method to update a draggable destinations__*
///
///### Uses:
/// ```dart
///  await processDestinations(context);
/// ```
///
/// @return Future
///
Future processDestinations(context) async {
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

/// ## addDestination
/// *__Method to add a destination to memory__*
///
///### Uses:
/// ```dart
///  addDestination(destination);
/// ```
///
/// @return void
///
void addDestination(String destination) {
  var newIndex = globalctx.destinations.length - 1;
  if (!globalctx.destinations.contains(destination)) {
    globalctx.destinations.insert(newIndex, destination);
  }

  setDestinationState(destination, newIndex, "selected", "tour");
}

/// ## setDestinationState
/// *__Method to change Destination states__*
///
///### Uses:
/// ```dart
///  setDestinationState(destination, index, "promoted", type);
/// ```
///
/// @return void
///
void setDestinationState(dest, index, state, type) {
  globalctx.states["destinations"][index] ??= {}.obs;
  globalctx.states["destinations"][index]["destination"] = dest;
  globalctx.states["destinations"][index]["index"] = index;
  globalctx.states["destinations"][index]["state"] = state;
  globalctx.states["destinations"][index]["type"] = type;
}

/// ## validateDragDestinationOptions
/// *__Method to validate graphic drag destination options__*
///
///### Uses:
/// ```dart
///  if (isListed ||
///         !validateDragDestinationOptions(destination, index, type).value)
/// ```
///
/// @return RxBool
///
RxBool validateDragDestinationOptions(destination, index, type) {
  bool galapagos = getFormValue(globalctx.memory, "tour", "galapagos", false);
  bool isArrival = index == 0 && type == "arrival";
  int days = int.parse(getFormValue(
      globalctx.memory["destinations"], index, "explorationDay", "0"));
  bool isDeparture =
      destination == departure["description"] && type == "departure";
  bool isSelected = getDestinationState(destination, index, type) == "selected";
  bool isPromoted = getDestinationState(destination, index, type) == "promoted";
  bool isArrivalPromoted =
      getDestinationState(arrival["description"], 0, "arrival") == "promoted";
  bool isTour = !isArrival && !isDeparture;
  bool isDepartureConsistent = (destDraggable.value != 0 &&
      globalctx.promotedDestinations.length !=
          globalctx.selectedDestinations.length &&
      globalctx.promotedDestinations.length >=
          globalctx.selectedDestinations.length - 1 &&
      globalctx.selectedDestinations.length >= 3 &&
      globalctx.promotedDestinations.length >= 2 &&
      type == "departure");
  bool isAccumulated = accumulated.value > 0;
  bool isDayleft = dayleft.value > 0;
  bool arrivalRule = isArrival && isSelected && isDayleft;
  int cruiseFirstDayDirefferece =
      cruiseStartDate.value.difference(arrivalDate.value).inDays;
  bool preArrival =
      isArrival && galapagos && isDayleft && cruiseFirstDayDirefferece > 1;
  bool departureRule = isDeparture &&
      isDepartureConsistent &&
      isSelected &&
      isArrivalPromoted &&
      isAccumulated &&
      isDayleft;
  bool tourRule = isTour && isArrivalPromoted && isAccumulated && isDayleft;
  if (galapagos && days > 0) {
    return ((isPromoted || isSelected || isTour)).obs;
  }
  return ((preArrival || arrivalRule || departureRule || tourRule)).obs;
}

/// ## filterSelectedDestinations
/// *__Method to filter destinations__*
///
///### Uses:
/// ```dart
///  filterSelectedDestinations();
/// ```
///
/// @return void
///
void filterSelectedDestinations() {
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
      moveGraphDragDestinationOption(selected, idx, type);
      idx++;
    }
  }
}

/// ## moveGraphDragDestinationOption
/// *__Method to move graphic drag destination option__*
///
///### Uses:
/// ```dart
///   moveGraphDragDestinationOption(selected, idx, type);
/// ```
///
/// @return void
///
void moveGraphDragDestinationOption(
    String destination, int index, String type) {
  var state = "selected";
  setDestinationState(destination, index, state, type);
  globalctx.selectedDestinations.add(destination);
  globalctx.destinationDragData.value.add(DragDestinationWidget(
      destination: destination, index: index, type: type, out: false));
}

/// ## deleteGraphDragDestinationOption
/// *__Method to delete destinations__*
///
///### Uses:
/// ```dart
///  onTap: () {
///     deleteGraphDragDestinationOption(destination);
///      },
/// ```
///
/// @return void
///
void deleteGraphDragDestinationOption(String destination) {
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

/// ## getDestinationById
/// *__Method to get destination data from id as input__*
///
///### Uses:
/// ```dart
///  arrival.value = getDestinationById(arrivalPort.value);
/// ```
///
/// @return dynamic
///
dynamic getDestinationById(destId) {
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

/// ## getDestinationIdByName
/// *__Method to get destination id from name as input__*
///
///### Uses:
/// ```dart
///  if (arrivalPort.value != getDestinationIdByName(destination) &&
/// ```
///
/// @return dynamic
///
dynamic getDestinationIdByName(String destination) {
  var id = getDestinationByName(destination)["code"].toString();
  return id;
}

/// ## getDestinationValueByName
/// *__Method to get destination value from name as input__*
///
///### Uses:
/// ```dart
///  var destData = getDestinationValueByName(destination);
/// ```
///
/// @return dynamic
///
getDestinationValueByName(String destination) {
  var result = [];
  try {
    result = getDestinationByName(destination)["value"];
  } catch (e) {
    log(e);
  }
  return result;
}

/// ## getDestinationByName
/// *__Method to get destination from name as input__*
///
///### Uses:
/// ```dart
///  var destData = getDestinationByName(destination);
/// ```
///
/// @return dynamic
///
dynamic getDestinationByName(String destination) {
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

/// ## getDestinationState
/// *__Method to get destination from name as input__*
///
///### Uses:
/// ```dart
///  bool isSelected = getDestinationState(destination, index, type) == "selected";
/// ```
///
/// @return String
///
String getDestinationState(destination, index, type) {
  var state = "suggested";
  globalctx.states["destinations"][index] ??= {}.obs;
  state = globalctx.states["destinations"][index]["state"] ?? "suggested";
  if (globalctx.states["destinations"][index]["type"] != type) {
    state = "suggested";
  }
  return state;
}

/// ## updateTotalLeftAccumulated
/// *__Method to update destination accumulated days __*
///
///### Uses:
/// ```dart
///  updateTotalLeftAccumulated();
/// ```
///
/// @return void
///
void updateTotalLeftAccumulated() {
  accumulated.value = 0;
  if (destinations.isNotEmpty) {
    for (var destination in destinations.keys) {
      accumulated.value += getDestinationDay(destination) as int;
    }
  }
  dayleft.value = totalDays.value - accumulated.value;
}


/// ## getMaxTrValue
/// *__Method to update destination accumulated days __*
///
///### Uses:
/// ```dart
///  updateTotalLeftAccumulated();
/// ```
///
/// @return void
///
getMaxTrValue(tr) {
  return trMaxValues[tr];
}

getMaxTrHourValue(tr) {
  return trMaxHourValues[tr];
}

getAgeMaxTrValue(tr) {
  return trAgeMaxValues[tr];
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
